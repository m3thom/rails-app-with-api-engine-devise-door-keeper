class DummyChannel < ApplicationCable::Channel
  def subscribed
    stream_from :dummy
    # In the rails console
    # ActionCable.server.broadcast "dummy", {test: "data from dummy channel"}

    begin
      # No implement yet
      puts current_user
    rescue
      puts "no current_user"
    end
  end
end