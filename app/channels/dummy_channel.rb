class DummyChannel < ApplicationCable::Channel
  def subscribed
    stream_from :dummy
    # In the rails console
    # ActionCable.server.broadcast "dummy", {test: "data from dummy channel"}
    puts "current_user.id #{current_user.id}"
  end
end