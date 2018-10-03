ContentfulModel.configure do |config|
  config.access_token = "27e2a45eb446c5cd25b246731019d2b17ce3b4bc9fd3af3ebcb846209b021ccd" # Required
  config.preview_access_token = "your preview token in here" # Optional - required if you want to use the preview API
  config.management_token = "your management token in here" # Optional - required if you want to update or create content
  config.space = "ccmcxm40da0n" # Required
  config.environment = "master" # Optional - defaults to 'master'
  config.default_locale = "en-US" # Optional - defaults to 'en-US'
  config.options = { # Optional
    #extra options to send to the Contentful::Client
  }
end