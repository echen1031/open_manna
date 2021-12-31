class VerseDecorator < Draper::Decorator
  delegate_all

  def text_message
    reference+' - '+text+' - OpenManna.com. Reply STOP to stop subscription.'
  end
end
