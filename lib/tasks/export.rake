namespace :export do 
  desc "Prints Articles as a seed.rb file"
  task :seed_article_format => :environment do
    Article.all.each do |article|
      puts "Article.create(title: \"#{article.title}\", description: \"#{article.description}\")"
    end
  end
end