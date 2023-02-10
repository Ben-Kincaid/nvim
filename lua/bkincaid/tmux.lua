-- Conditionally map <leader>z to tmux maximizing method
if(os.getenv("TMUX")) then
	vim.keymap.set("n", "<leader>z", function()
		vim.fn.jobstart("tmux resize-pane -Z && sleep 0.05", {
			on_exit = function()
				vim.api.nvim_command("horizontal wincmd =")
				vim.api.nvim_command("vertical wincmd =")
			end
		})
	end)
end
