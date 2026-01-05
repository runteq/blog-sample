class Admin::BaseController < ApplicationController
  http_basic_authenticate_with(
    name: ENV.fetch("BLOG_USER", "admin"),
    password: ENV.fetch("BLOG_PASSWORD", "password")
  )

  layout "admin"
end
