package 'sysstat' do
  action :install
end

case node[:platform]
  when "ubuntu", "debian"
template '/etc/sysstat/sysstat' do
  source 'sysstat.options.erb'
  mode 0644
  owner 'root'
  group 'root'
  variables(
    sar_history: node['sar']['options']['sar_history'],
    sdac_options: node['sar']['options']['sdac_options'],
    sar_compress: node['sar']['options']['sar_compress']
  )
  end
end
end

template '/etc/default/sysstat' do
  source 'sysstat.default.erb'
  mode 0644
  owner 'root'
  group 'root'
  variables(
    sar_enabled: node['sar']['enabled'],
    sa1_options: node['sar']['sa1_options'],
    sa2_options: node['sar']['sa2_options']
  )
end

template '/etc/cron.d/sysstat' do
  source 'sysstat.cron.erb'
  mode 0644
  owner 'root'
  group 'root'
  variables(
    run_every_minutes: node['sar']['cron']['run_every_minutes']
  )
