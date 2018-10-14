namespace :docker do
  desc "PUSH docker images to Dockerhub"
  task push_image: :environment do
    TAG = `git rev-parse --short HEAD`.strip

    puts "Building Docker image"
    sh "docker build -t namtx/rails_mysql_kubernetes:#{TAG} ."

    IMAGE_ID = `docker images | grep namtx\/rails_mysql_kubernetes | head -n1 | awk '{print $3}'`.strip

    puts "Tagging latest image"
    sh "docker tag #{IMAGE_ID} namtx/rails_mysql_kubernetes:latest"

    puts "Pushing Docker image"
    sh "docker push namtx/rails_mysql_kubernetes:#{TAG}"
    sh "docker push namtx/rails_mysql_kubernetes:latest"

    puts "Done"
  end
end
