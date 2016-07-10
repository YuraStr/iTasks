class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable,
         :omniauth_providers => [:facebook, :vkontakte, :twitter]

  def self.find_for_facebook_oauth access_token
    if user = User.where(:username => access_token.extra.raw_info.name).first
      user
    else 
      User.create!(:provider => access_token.provider, 
      	:url => "https://www.facebook.com/" + access_token.extra.raw_info.id, 
      	:username => access_token.extra.raw_info.name, 
      	:email => access_token.extra.raw_info.email, 
      	:password => Devise.friendly_token[0,20]) 
    end

  end
 def self.find_for_vkontakte_oauth access_token
    if user = User.where(:url => access_token.info.urls.Vkontakte).first
      user
    else 
      User.create!(:provider => access_token.provider, 
      	:url => access_token.info.urls.Vkontakte, 
      	:username => access_token.info.name, 
      	:email =>  access_token.info.urls.Vkontakte + "@vk.com", 
      	:password => Devise.friendly_token[0,20]) 
    end
  end

  def self.find_for_twitter_oauth access_token
    if user = User.where(:url => access_token.info.urls.Twitter).first
      user
    else 
      User.create!(:provider => access_token.provider, 
      	:url => access_token.info.urls.Twitter, 
      	:username => access_token.info.name, 
      	:email => access_token.info.urls.Twitter+"@tw.com", 
      	:password => Devise.friendly_token[0,20]) 
    end
  end
end
