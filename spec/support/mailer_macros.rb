module MailerMacros
  def last_email
    ActionMailer::Base.deliveries.last
  end

  def reset_email
    ActionMailer::Base.deliveries = []
  end

  def links_in_email(email)
    if email.content_type =~ /text\/html/
      Nokogiri::HTML::Document.parse(email.body.to_s).search('a').map{|a| a[:href] }
    else
      URI.extract(email.body.to_s, ['http', 'https'])
    end
  end
end
