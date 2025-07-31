require("obsidian").setup({
	legacy_commands = false,
	workspaces = {
		{
			name = "main",
			path = "~/Obsidian/main",
		},
	},

	daily_notes = {
		folder = "dailies",
		default_tags = { "daily_notes" },
		workdays_only = true,
		template = "daily.md",
	},

	completion = {
		nvim_cmp = false,
		blink = true,
		min_chars = 2,
	},

	templates = {
		folder = "ztemplates",
	}
})
