-- Lazy-loading helpers on top of Neovim's native plugin manager (vim.pack,
-- 0.12+). vim.pack only installs/updates plugin code on disk and can load a
-- plugin (`:packadd`), but unlike lazy.nvim it has no concept of "only load
-- this plugin on X event/filetype/command/keypress". These helpers add that
-- layer so load times stay fast, mirroring the previous lazy.nvim triggers.
--
-- Usage pattern:
--   1. `vim.pack.add({ ...every plugin spec... }, { load = false })` once,
--      upfront, so everything is installed to disk and reachable via
--      `require()` (the directory is on 'runtimepath' even unloaded).
--   2. For plugins needed at startup, call `M.now(name, config)`.
--   3. For everything else, call `M.on_event/on_ft/on_cmd/on_keys/
--      on_very_lazy(name, config, ...)` so the plugin is only fully loaded
--      (`:packadd` + its config function) the first time it's actually
--      needed.

local M = {}

local loaded = {}

--- Fully load (`:packadd`, sourcing plugin/ftdetect/after files) and run
--- `config()` for a plugin. Idempotent — safe to call from multiple
--- triggers registered against the same `name`.
function M.load(name, config)
	if loaded[name] then
		return
	end
	loaded[name] = true
	local ok, err = pcall(vim.cmd.packadd, name)
	if not ok then
		vim.notify(("pack_loader: packadd '%s' failed: %s"):format(name, err), vim.log.levels.WARN)
	end
	if config then
		config()
	end
end

--- Load immediately (for plugins needed at/near startup).
function M.now(name, config)
	M.load(name, config)
end

--- Load the first time one of `events` fires (optionally scoped to
--- `pattern`).
function M.on_event(name, config, events, pattern)
	vim.api.nvim_create_autocmd(events, {
		pattern = pattern,
		once = true,
		callback = function()
			M.load(name, config)
		end,
	})
end

--- Load the first time the buffer's filetype matches one of `fts`, then
--- re-fire FileType for that buffer so any ftplugin/syntax/indent files that
--- just became available on 'runtimepath' actually get applied — plain
--- `:packadd` doesn't retroactively redo filetype autocommands that already
--- ran earlier in this same FileType event.
function M.on_ft(name, config, fts)
	vim.api.nvim_create_autocmd("FileType", {
		pattern = fts,
		once = true,
		callback = function(ev)
			M.load(name, config)
			vim.api.nvim_exec_autocmds("FileType", { buffer = ev.buf })
		end,
	})
end

--- Load the first time any of `cmds` (user command names) is invoked, then
--- replay the exact command line (range/bang/args) against the real command
--- the plugin just registered.
function M.on_cmd(name, config, cmds)
	for _, cmd in ipairs(cmds) do
		vim.api.nvim_create_user_command(cmd, function(cmd_opts)
			pcall(vim.api.nvim_del_user_command, cmd)
			M.load(name, config)
			local range = cmd_opts.range > 0 and (cmd_opts.line1 .. "," .. cmd_opts.line2) or ""
			vim.cmd(string.format("%s%s%s %s", range, cmd, cmd_opts.bang and "!" or "", cmd_opts.args))
		end, { nargs = "*", bang = true, range = true, complete = "file" })
	end
end

--- Load the first time any of `keys` is pressed.
--- `keys`: list of `{ lhs, rhs, mode = "n", desc = "..." }` (mirrors
--- lazy.nvim's `keys` spec shape):
---   - `rhs` is a function: called directly once the plugin is loaded.
---   - `rhs` is a string (e.g. "<cmd>Neotree toggle<CR>"): fed as keys once
---     the plugin is loaded.
---   - `rhs` is nil: the plugin's own `config()` is expected to set the
---     real mapping for `lhs`; the original keypress is replayed so that
---     mapping picks it up.
function M.on_keys(name, config, keys)
	for _, k in ipairs(keys) do
		local lhs = k[1]
		local rhs = k[2]
		local modes = k.mode or "n"
		local mode_list = type(modes) == "table" and modes or { modes }
		vim.keymap.set(modes, lhs, function()
			for _, mode in ipairs(mode_list) do
				pcall(vim.keymap.del, mode, lhs)
			end
			M.load(name, config)
			if type(rhs) == "function" then
				rhs()
			else
				-- "i" re-inserts at the FRONT of typeahead (not the end), so a
				-- multi-key lhs like mini.surround's "sa" is immediately
				-- followed by whatever motion keys the user already queued
				-- after it (e.g. "saiw)"), instead of running after them.
				vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(rhs or lhs, true, true, true), "mi", false)
			end
		end, { desc = k.desc })
	end
end

--- Load once Nvim is idle right after startup — native equivalent of
--- lazy.nvim's `VeryLazy` event.
function M.on_very_lazy(name, config)
	vim.api.nvim_create_autocmd("VimEnter", {
		once = true,
		callback = function()
			vim.schedule(function()
				M.load(name, config)
			end)
		end,
	})
end

--- Run `fn(path)` once, right after vim.pack freshly installs or updates
--- `name` — native equivalent of lazy.nvim's `build = ...`. Must be
--- registered BEFORE the `vim.pack.add()` call that may trigger the very
--- first install, or the event for that install is missed.
function M.on_build(name, fn)
	vim.api.nvim_create_autocmd("PackChanged", {
		callback = function(ev)
			if ev.data.spec.name == name and (ev.data.kind == "install" or ev.data.kind == "update") then
				fn(ev.data.path)
			end
		end,
	})
end

return M
