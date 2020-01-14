##
# Cookbook:: node
# Spec:: default
#
# Copyright:: 2020, The Authors, All Rights Reserved.



require 'spec_helper'



describe 'node::default' do
  context 'When all attributes are default, on Ubuntu 16.04' do
    let(:chef_run) do
      # for a complete list of available platforms and versions see:
      # https://github.com/customink/fauxhai/blob/master/PLATFORMS.md
      runner = ChefSpec::ServerRunner.new(platform: 'ubuntu', version: '16.04')
      runner.converge(described_recipe)
    end



    it 'converges successfully' do
      expect { chef_run }.to_not raise_error
    end



    it 'Should Install NGINX' do
      expect(chef_run).to install_package "nginx"
    end



    it 'enable nginx service' do
    expect(chef_run).to enable_service "nginx"
    end



    it 'start nginx service' do
      expect(chef_run).to start_service "nginx"
    end



    it 'Should Install NodeJS from a recipe' do
      expect(chef_run).to include_recipe("nodejs")
    end



    it 'Should install pm2 via npm' do
      expect(chef_run).to install_nodejs_npm('pm2')
    end



    it 'should create a proxy.conf template in /etc/nginx/sites-available' do
      expect(chef_run).to create_template "/etc/nginx/sites-available/proxy.conf"
    end



    it 'should create symbolic link from sites-available to sites-enabled' do
      expect(chef_run).to create_link("/etc/nginx/sites-enabled/proxy.conf").with_link_type(:symbolic)
    end



    it 'should delete the symbolic link from the default config in sites-enabled' do
      expect(chef_run).to delete_link("/etc/nginx/sites-enabled/default")
    end



    at_exit { ChefSpec::Coverage.report! }
  end



end
