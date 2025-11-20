require 'date'
class UserMailer < ApplicationMailer
  default from: 'ankothari@gmail.com'

  def welcome_email
    @user = params[:user]
    @url  = 'http://example.com/login'
    mail(to: @user.email, subject: 'Welcome to My Awesome Site')
  end

  def questions_list(user)
    @user = user
    url = "https://frozen-garden-53484.herokuapp.com"
    api = "#{url}/go/cluster_names"
    uri = URI.parse(api)
    user_response = Net::HTTP.get(uri)
    user = JSON.parse(user_response)
    @questions = Hash.new { [] }
    go = []
    for item in user
      go.push({title: item[1], postId: item[0]})
    end
    @questions["go"] = go

    api = "#{url}/kubernetes/cluster_names"
    uri = URI.parse(api)
    user_response = Net::HTTP.get(uri)
    user = JSON.parse(user_response)
    kubernetes = []
    for item in user
      kubernetes.push({title: item[1], postId: item[0]})
    end
    @questions["kubernetes"] = kubernetes

    # api = "http://127.0.0.1:3000/sql/top"
    # uri = URI.parse(api)
    # user_response = Net::HTTP.get(uri)
    # user = JSON.parse(user_response)
    # sql = []
    # for item in user
    #   post = item["post"]
    #   sql.push({title: post["title"], postId: post["postId"]})
    # end
    # @questions["sql"] = sql
    #
    api = "#{url}/docker/cluster_names"
    uri = URI.parse(api)
    user_response = Net::HTTP.get(uri)
    user = JSON.parse(user_response)
    docker = []
    for item in user
      docker.push({title: item[1], postId: item[0]})
    end
    @questions["docker"] = docker


    # api = "#{url}/pca/cluster_names"
    # uri = URI.parse(api)
    # user_response = Net::HTTP.get(uri)
    # user = JSON.parse(user_response)
    # pca = []
    # for item in user
    #   pca.push({title: item[1], postId: item[0]})
    # end
    # @questions["pca"] = pca


    # api = "#{url}/svd/cluster_names"
    # uri = URI.parse(api)
    # user_response = Net::HTTP.get(uri)
    # user = JSON.parse(user_response)
    # svd = []
    # for item in user
    #   svd.push({title: item[1], postId: item[0]})
    # end
    # @questions["svd"] = svd


    # api = "http://127.0.0.1:3000/bayesian/cluster_names"
    # uri = URI.parse(api)
    # user_response = Net::HTTP.get(uri)
    # user = JSON.parse(user_response)
    # bayesian = []
    # for item in user
    #   bayesian.push({title: item[1], postId: item[0]})
    # end
    # @questions["bayesian"] = bayesian


    # api = "http://127.0.0.1:3000/eigenvalues/cluster_names"
    # uri = URI.parse(api)
    # user_response = Net::HTTP.get(uri)
    # user = JSON.parse(user_response)
    # eigenvalues = []
    # for item in user
    #   eigenvalues.push({title: item[1], postId: item[0]})
    # end
    # @questions["eigenvalues"] = eigenvalues

    api = "#{url}/linux/cluster_names"
    uri = URI.parse(api)
    user_response = Net::HTTP.get(uri)
    user = JSON.parse(user_response)
    linux = []
    for item in user
      linux.push({title: item[1], postId: item[0]})
    end
    @questions["linux"] = linux

    api = "#{url}/sql/cluster_names"
    uri = URI.parse(api)
    user_response = Net::HTTP.get(uri)
    user = JSON.parse(user_response)
    sql = []
    for item in user
      sql.push({title: item[1], postId: item[0]})
    end
    @questions["sql"] = sql

    api = "#{url}/process/cluster_names"
    uri = URI.parse(api)
    user_response = Net::HTTP.get(uri)
    user = JSON.parse(user_response)
    process = []
    for item in user
      process.push({title: item[1], postId: item[0]})
    end
    @questions["process"] = process

    api = "#{url}/amazon-web-services/cluster_names"
    uri = URI.parse(api)
    user_response = Net::HTTP.get(uri)
    user = JSON.parse(user_response)
    aws = []
    for item in user
      aws.push({title: item[1], postId: item[0]})
    end
    @questions["amazon-web-services"] = aws

    api = "#{url}/multithreading/cluster_names"
    uri = URI.parse(api)
    user_response = Net::HTTP.get(uri)
    user = JSON.parse(user_response)
    multithreading = []
    for item in user
      multithreading.push({title: item[1], postId: item[0]})
    end
    @questions["multithreading"] = multithreading


    api = "#{url}/google-kubernetes-engine/cluster_names"
    uri = URI.parse(api)
    user_response = Net::HTTP.get(uri)
    user = JSON.parse(user_response)
    gke = []
    for item in user
      gke.push({title: item[1], postId: item[0]})
    end
    @questions["google-kubernetes-engine"] = gke

    # api = "http://127.0.0.1:3000/linux/top"
    # uri = URI.parse(api)
    # user_response = Net::HTTP.get(uri)
    # user = JSON.parse(user_response)
    # linux = []
    # for item in user
    #   post = item["post"]
    #   linux.push({title: post["title"], postId: post["postId"]})
    # end
    # @questions["linux"] = linux
    mail(to: @user.email, subject: 'Here are some questions for you to read.')
  end


  def notifier(user)
    @user = user
    mail(to: @user.email, subject: 'Topics you have seen but not yet answered.')
  end

  def day_summary(user)
    @user = user
    @date = Date.today
    mail(to: @user.email, subject: 'Daily Summary from Stackexchange')
  end
end
