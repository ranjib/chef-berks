require 'chef/config'

class Chef
  class Config
    berksfile platform_specific_path("/etc/chef/Berksfile")
    use_berkshelf false
  end
end
