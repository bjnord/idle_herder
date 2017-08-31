# don't generate RSpec for views; don't generate empty helpers
Rails.application.config.generators do |g|
  g.view_specs false
  g.helper false
  g.helper_specs false
end
