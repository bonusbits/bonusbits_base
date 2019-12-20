# Upload release to my public S3 bucket for the launcher button to use. Plus, the deploy tasks can use.

# WIP
namespace :cloudformation do
  desc 'Deploy local'
  task :s3_upload do
    sh "find /Users/levon/Development/bonusbits/bonusbits_base/cloudformation -type f -name '*.yml' -not -path '*/tmp/*' -not -path '*/extras/*' -not -path '*/archive/*' | xargs -n 1 -I FILE aws s3 cp FILE s3://bonusbits-public/cloudformation-templates/cookbooks/bonusbits_base --profile bonusbits"
  end
end
