require('litee.lib').setup()              -- ldelossa/litee.nvim
require('litee.gh').setup({               -- ldelossa/gh.nvim
  map_resize_keys = true,
  icon_set = 'nerd',
  actions = '<C-m>',
  keymaps = {
    -- when inside a gh.nvim panel, this key will open a node if it has
    -- any futher functionality. for example, hitting <CR> on a commit node
    -- will open the commit's changed files in a new gh.nvim panel.
    open = "<CR>",
    -- when inside a gh.nvim panel, expand a collapsed node
    expand = "zo",
    -- when inside a gh.nvim panel, collpased and expanded node
    collapse = "zc",
    -- when cursor is over a "#1234" formatted issue or PR, open its details
    -- and comments in a new tab.
    goto_issue = "gd",
    -- show any details about a node, typically, this reveals commit messages
    -- and submitted review bodys.
    details = "d",
    -- inside a convo buffer, submit a comment
    submit_comment = "<C-s>",
    -- inside a convo buffer, when your cursor is ontop of a comment, open
    -- up a set of actions that can be performed.
    actions = "<leader>a",
    -- inside a thread convo buffer, resolve the thread.
    resolve_thread = "<C-r>",
    -- inside a gh.nvim panel, if possible, open the node's web URL in your
    -- browser. useful particularily for digging into external failed CI
    -- checks.
    goto_web = "gx"
  }
})
require("which-key").register({
    g = {
        name = "+Git",
        h = {
            name = "+Github",
            c = {
                name = "+Commits",
                c = { "<cmd>GHCloseCommit<cr>", "Close" },
                e = { "<cmd>GHExpandCommit<cr>", "Expand" },
                o = { "<cmd>GHOpenToCommit<cr>", "Open To" },
                p = { "<cmd>GHPopOutCommit<cr>", "Pop Out" },
                z = { "<cmd>GHCollapseCommit<cr>", "Collapse" },
            },
            i = {
                name = "+Issues",
                p = { "<cmd>GHPreviewIssue<cr>", "Preview" },
            },
            l = {
                name = "+Litee",
                t = { "<cmd>LTPanel<cr>", "Toggle Panel" },
            },
            r = {
                name = "+Review",
                b = { "<cmd>GHStartReview<cr>", "Begin" },
                c = { "<cmd>GHCloseReview<cr>", "Close" },
                d = { "<cmd>GHDeleteReview<cr>", "Delete" },
                e = { "<cmd>GHExpandReview<cr>", "Expand" },
                s = { "<cmd>GHSubmitReview<cr>", "Submit" },
                z = { "<cmd>GHCollapseReview<cr>", "Collapse" },
            },
            p = {
                name = "+Pull Request",
                c = { "<cmd>GHClosePR<cr>", "Close" },
                d = { "<cmd>GHPRDetails<cr>", "Details" },
                e = { "<cmd>GHExpandPR<cr>", "Expand" },
                o = { "<cmd>GHOpenPR<cr>", "Open" },
                p = { "<cmd>GHPopOutPR<cr>", "PopOut" },
                r = { "<cmd>GHRefreshPR<cr>", "Refresh" },
                t = { "<cmd>GHOpenToPR<cr>", "Open To" },
                z = { "<cmd>GHCollapsePR<cr>", "Collapse" },
            },
            t = {
                name = "+Threads",
                c = { "<cmd>GHCreateThread<cr>", "Create" },
                n = { "<cmd>GHNextThread<cr>", "Next" },
                t = { "<cmd>GHToggleThread<cr>", "Toggle" },
            },
        },
    },
}, { prefix = "<leader>" })