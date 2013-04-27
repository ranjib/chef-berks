
require 'chef/client'
require 'monkey_patches/chef/config'
require 'berkshelf'
require 'berkshelf/berksfile'
require 'tmpdir'
require 'fileutils'

class Chef
  class Client
    def setup_run_context
      if Chef::Config[:solo]
        if Chef::Config[:use_berkshelf]
          cookbook_collection = run_berks
        else
          Chef::Cookbook::FileVendor.on_create { |manifest| Chef::Cookbook::FileSystemFileVendor.new(manifest, Chef::Config[:cookbook_path]) }
          cl = Chef::CookbookLoader.new(Chef::Config[:cookbook_path])
          cl.load_cookbooks
          cookbook_collection = Chef::CookbookCollection.new(cl)
        end
        run_context = Chef::RunContext.new(node, cookbook_collection, @events)
      else
        if Chef::Config[:use_berkshelf]
          cookbook_collection = run_berks
        else
          Chef::Cookbook::FileVendor.on_create { |manifest| Chef::Cookbook::RemoteFileVendor.new(manifest, rest) }
          cookbook_hash = sync_cookbooks
          cookbook_collection = Chef::CookbookCollection.new(cookbook_hash)
        end  
        run_context = Chef::RunContext.new(node, cookbook_collection, @events)
      end
      run_status.run_context = run_context

      run_context.load(@run_list_expansion)
      assert_cookbook_path_not_empty(run_context)
      run_context
    end

    def run_berks
      berksfile = Berkshelf::Berksfile.from_file(Chef::Config[:berksfile])
      opts= {path:Chef::Config[:cookbook_path].first}
      berksfile.install(opts)
      Chef::Cookbook::FileVendor.on_create { |manifest| Chef::Cookbook::FileSystemFileVendor.new(manifest, Chef::Config[:cookbook_path]) }
      cl = Chef::CookbookLoader.new(Chef::Config[:cookbook_path])
      cl.load_cookbooks
      cookbook_collection = Chef::CookbookCollection.new(cl)
      cookbook_collection
    end
  end  
end

