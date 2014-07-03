require 'thread'
require 'launchy'

task :server do
  sh 'bundle exec jekyll server'
end

task :watch do
  Thread.new do
    sleep 1
    Launchy.open "http://localhost:4000/"
  end
  sh 'bundle exec jekyll server --watch --draft'
end
