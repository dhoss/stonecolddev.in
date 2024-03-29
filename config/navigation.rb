# -*- coding: utf-8 -*-
# Configures your navigation
SimpleNavigation::Configuration.run do |navigation|
  navigation.items do |primary|
    primary.item :posts,   'Posts',   posts_path
    primary.item :photos,  'Photos',  photos_path
    primary.item :galleries, 'Galleries', galleries_path
    primary.item :account, 'Profile', user_path(current_user||{:id=>0}),          if:     proc { user_signed_in? }
    primary.item :login,   'Log in',  new_user_session_path,                      unless: proc { user_signed_in? }
    primary.item :logout,  'Log out', destroy_user_session_path, method: :delete, if:     proc { user_signed_in? }
    primary.item :signup,  'Sign up', new_user_registration_path,                 unless: proc { user_signed_in? }
    #primary.item :admin, 'Admin', admin_path if: proc {current_user.admin?}
    primary.dom_class = 'blog-nav-item'

  end
end
