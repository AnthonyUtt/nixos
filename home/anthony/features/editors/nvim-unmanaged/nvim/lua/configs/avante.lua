return {
  mode = "legacy",
  provider = "claude",
  auto_suggestions_provider = nil,
  cursor_applying_provider = nil,
  behaviour = {
    auto_focus_sidebar = true,
    auto_suggestions = false,
    auto_apply_diff_after_generation = true,
    jump_result_buffer_on_finish = false,
    support_paste_from_clipboard = true,
  },
  hints = {
    enable = true,
  },
  repo_map = {
    ignore_patterns = { "%.git", "%.worktree", "__pycache__", "node_modules" },
  },
  claude = {
    endpoint = "https://api.anthropic.com",
    model = "claude-3-7-sonnet-20250219",
    temperature = 0,
    max_tokens = 4096,
  },
  copilot = {
    endpoint = "https://api.githubcopilot.com/",
    model = "claude-3.7-sonnet",
    temperature = 0,
    max_tokens = 32768,
  },
  ollama = {
    api_key_name = "",
    endpoint = "https://ollama.uttho.me",
    model = "qwen2.5-coder:7b",
    temperature = 0,
    max_tokens = 32768,
  },
  vendors = {
    applying = {
      __inherited_from = "ollama",
      model = "llama3.2:3b",
    },
  },
}
