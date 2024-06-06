Rails.application.config.middleware.use OmniAuth::Builder do
  provider :github, ENV["GITHUB_KEY"], ENV["GITHUB_SECRET"], callback_path: '/users/auth/github/callback', scope: 'user:email'
end
