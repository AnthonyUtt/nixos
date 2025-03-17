return {
  provider = "copilot",
  auto_suggestions_provider = "ollama",
  cursor_applying_provider = "applying",
  behaviour = {
    auto_suggestions = false,
    enable_cursor_planning_mode = false,
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
      api_key_name = "",
      endpoint = "https://ollama.uttho.me",
      model = "llama3.2:3b",
      temperature = 0,
      max_tokens = 32768,
    },
  },
}
