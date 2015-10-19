require 'spec_helper'

describe CF::App::Credentials do
  let(:vcap_services_v1) do
    {
      'cleardb-n/a'        => [
        {
          'name'        => 'master-db',
          'label'       => 'cleardb-n/a',
          'tags'        => [
            'mysql',
            'relational',
            'oracle'
          ],
          'plan'        => 'scream',
          'credentials' => {
            'jdbcUrl'  => 'jdbc:mysql://640cd7d903851807:cc89b00738b95a69@cleardb.example.com:3306/db_29098221a2dc0c59',
            'uri'      => 'mysql://640cd7d903851807:cc89b00738b95a69@cleardb.example.com:3306/db_29098221a2dc0c59?reconnect=true',
            'name'     => 'db_29098221a2dc0c59',
            'hostname' => 'cleardb.example.com',
            'port'     => '3306',
            'username' => '640cd7d903851807',
            'password' => 'cc89b00738b95a69'
          }
        },
        {
          'name'        => 'slave-db',
          'label'       => 'cleardb-n/a',
          'tags'        => [
            'mysql',
            'relational'
          ],
          'plan'        => 'scream',
          'credentials' => {
            'jdbcUrl'  => 'jdbc:mysql://1b66152fc013c97e:7276a72689ddf6f3@cleardb.example.com:3306/db_f542acb65cfc54a1',
            'uri'      => 'mysql://1b66152fc013c97e:7276a72689ddf6f3@cleardb.example.com:3306/db_f542acb65cfc54a1?reconnect=true',
            'name'     => 'db_f542acb65cfc54a1',
            'hostname' => 'cleardb.example.com',
            'port'     => '3306',
            'username' => '1b66152fc013c97e',
            'password' => '7276a72689ddf6f3'
          }
        }
      ],

      'rediscloud-dev-n/a' => [
        {
          'name'        => 'queue',
          'label'       => 'rediscloud-dev-n/a',
          'tags'        => [
            'redis',
            'key-value'
          ],
          'plan'        => '100mb',
          'credentials' => {
            'port'     => '17345',
            'hostname' => 'garantiadata.example.com',
            'password' => '3a9c2eb0ed895ab1'
          }
        }
      ],

      'github-repo-2'      => [
        {
          'name'        => 'github-repository-123',
          'label'       => 'github-repo-2',
          'tags'        => [
            'github'
          ],
          'plan'        => 'free',
          'credentials' => {
            'username'     => 'octocat',
            'access_token' => 'some-token'
          }
        },
        {
          'name'        => 'github-repository-456',
          'label'       => 'github-repo-2',
          'tags'        => [
            'github'
          ],
          'plan'        => 'free',
          'credentials' => {
            'username'     => 'octocat',
            'access_token' => 'some-token'
          }
        }
      ]
    }
  end

  let(:vcap_services_v2) do
    {
      'cleardb'        => [
        {
          'name'        => 'master-db',
          'label'       => 'cleardb',
          'tags'        => [
            'mysql',
            'relational',
            'oracle'
          ],
          'plan'        => 'scream',
          'credentials' => {
            'jdbcUrl'  => 'jdbc:mysql://640cd7d903851807:cc89b00738b95a69@cleardb.example.com:3306/db_29098221a2dc0c59-v2',
            'uri'      => 'mysql://640cd7d903851807:cc89b00738b95a69@cleardb.example.com:3306/db_29098221a2dc0c59?reconnect=true',
            'name'     => 'db_29098221a2dc0c59',
            'hostname' => 'cleardb.example.com',
            'port'     => '3306',
            'username' => '640cd7d903851807',
            'password' => 'cc89b00738b95a69'
          }
        },
        {
          'name'        => 'slave-db',
          'label'       => 'cleardb',
          'tags'        => [
            'mysql',
            'relational'
          ],
          'plan'        => 'scream',
          'credentials' => {
            'jdbcUrl'  => 'jdbc:mysql://1b66152fc013c97e:7276a72689ddf6f3@cleardb.example.com:3306/db_f542acb65cfc54a1-v2',
            'uri'      => 'mysql://1b66152fc013c97e:7276a72689ddf6f3@cleardb.example.com:3306/db_f542acb65cfc54a1?reconnect=true',
            'name'     => 'db_f542acb65cfc54a1',
            'hostname' => 'cleardb.example.com',
            'port'     => '3306',
            'username' => '1b66152fc013c97e',
            'password' => '7276a72689ddf6f3'
          }
        }
      ],

      'rediscloud-dev' => [
        {
          'name'        => 'queue',
          'label'       => 'rediscloud-dev',
          'tags'        => [
            'redis',
            'key-value'
          ],
          'plan'        => '100mb',
          'credentials' => {
            'port'     => '17345-v2',
            'hostname' => 'garantiadata.example.com',
            'password' => '3a9c2eb0ed895ab1'
          }
        }
      ],

      'github-repo-2'  => [
        {
          'name'        => 'github-repository-123',
          'label'       => 'github-repo-2',
          'tags'        => [
            'github'
          ],
          'plan'        => 'free',
          'credentials' => {
            'username'     => 'octocat-v2',
            'access_token' => 'some-token-1'
          }
        },
        {
          'name'        => 'github-repository-456',
          'label'       => 'github-repo-2',
          'tags'        => [
            'github'
          ],
          'plan'        => 'free',
          'credentials' => {
            'username'     => 'octocat-v2',
            'access_token' => 'some-token-2'
          }
        }
      ]}
  end

  describe 'for VCAP_SERVICES of' do
    %w|v1 v2|.each do |version|
      describe "#{version} format" do

        if version == "v1"
          let(:vcap_services) { vcap_services_v1 }
          let(:cleardb_key) { 'cleardb-n/a' }
          let(:rediscloud_dev_key) { 'rediscloud-dev-n/a' }
        else
          let(:vcap_services) { vcap_services_v2 }
          let(:cleardb_key) { 'cleardb' }
          let(:rediscloud_dev_key) { 'rediscloud-dev' }
        end

        def set_services
          ENV['VCAP_SERVICES'] = JSON.dump(vcap_services)
          CF::App::Service.instance_variable_set :@services, nil
        end

        before :each do
          set_services
        end

        describe '.find_by_service_name' do
          it 'returns credentials for the service with the given name' do
            expect(CF::App::Credentials.find_by_service_name('master-db')).to eq(vcap_services[cleardb_key][0]['credentials'])
            expect(CF::App::Credentials.find_by_service_name('slave-db')).to eq(vcap_services[cleardb_key][1]['credentials'])
            expect(CF::App::Credentials.find_by_service_name('queue')).to eq(vcap_services[rediscloud_dev_key][0]['credentials'])
            expect(CF::App::Credentials.find_by_service_name('non-existent')).to be_nil
          end
        end

        describe '.find_by_service_tag' do
          it 'returns credentials for the service with the given tag' do
            expect(CF::App::Credentials.find_by_service_tag('mysql')).to eq(vcap_services[cleardb_key][0]['credentials'])
            expect(CF::App::Credentials.find_by_service_tag('relational')).to eq(vcap_services[cleardb_key][0]['credentials'])
            expect(CF::App::Credentials.find_by_service_tag('redis')).to eq(vcap_services[rediscloud_dev_key][0]['credentials'])
            expect(CF::App::Credentials.find_by_service_tag('non-existent')).to be_nil
          end
        end

        describe '.find_all_by_all_service_tags' do
          context 'when searching by empty array' do
            it 'returns empty array because returning all services is not useful here' do
              expect(CF::App::Credentials.find_all_by_all_service_tags([])).to eq([])
            end
          end

          context 'when a service has exactly the same tag list as search' do
            it 'returns credentials for the service' do
              expect(CF::App::Credentials.find_all_by_all_service_tags(['mysql', 'relational', 'oracle'])).to eq([vcap_services[cleardb_key][0]['credentials']])
            end
          end

          context 'when a service has a superset or equal set of searched-for tags' do
            it 'returns credentials for the service(s)' do
              expect(CF::App::Credentials.find_all_by_all_service_tags(['mysql', 'relational'])).to eq([vcap_services[cleardb_key][0]['credentials'], vcap_services[cleardb_key][1]['credentials']])
            end
          end

          context 'when a service has a subset of searched-for tags' do
            it 'does not return the service' do
              expect(CF::App::Credentials.find_all_by_all_service_tags(['redis', 'key-value', 'slow'])).to eq([])
            end
          end

          context 'when a service has no tags in common with searched-for tags' do
            it 'does not return the service' do
              expect(CF::App::Credentials.find_all_by_all_service_tags(['a', 'nonexistent', 'service'])).to eq([])
            end
          end

          context 'when a service has no tags element' do
            before do
              vcap_services[rediscloud_dev_key][0].delete('tags')
              set_services
            end

            it 'does not return the service' do
              expect(CF::App::Credentials.find_all_by_all_service_tags(['redis', 'key-value'])).to eq([])
            end
          end
        end

        describe '.find_by_service_label' do
          it 'returns credentials for the service with the given label' do
            expect(CF::App::Credentials.find_by_service_label('cleardb')).to eq(vcap_services[cleardb_key][0]['credentials'])
            expect(CF::App::Credentials.find_by_service_label('rediscloud-dev')).to eq(vcap_services[rediscloud_dev_key][0]['credentials'])
            expect(CF::App::Credentials.find_by_service_label('redis')).to be_nil
            expect(CF::App::Credentials.find_by_service_label('non-existent')).to be_nil
          end
        end

        describe '.find_all_by_service_label' do
          it 'returns all services with the given label' do
            expect(CF::App::Credentials.find_all_by_service_label('non-existent')).to eq([])
            expect(CF::App::Credentials.find_all_by_service_label('rediscloud-dev')).to eq([vcap_services[rediscloud_dev_key][0]['credentials']])
            expect(CF::App::Credentials.find_all_by_service_label('github-repo')).to match_array([
                                                                                                vcap_services['github-repo-2'][0]['credentials'],
                                                                                                vcap_services['github-repo-2'][1]['credentials']
                                                                                            ])
          end
        end

        describe '.find_all_by_tag' do
          it 'returns all services with the given tag' do
            expect(CF::App::Credentials.find_all_by_service_tag('non-existent')).to eq([])
            expect(CF::App::Credentials.find_all_by_service_tag('redis')).to eq([vcap_services[rediscloud_dev_key][0]['credentials']])
            expect(CF::App::Credentials.find_all_by_service_tag('relational')).to match_array([
                                                                                                  vcap_services[cleardb_key][0]['credentials'],
                                                                                                  vcap_services[cleardb_key][1]['credentials']
                                                                                              ])
          end
        end
      end
    end
  end
end


