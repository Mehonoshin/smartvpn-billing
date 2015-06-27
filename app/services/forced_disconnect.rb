class ForcedDisconnect
  def initialize(user)
    @user = user
  end

  def invoke
    disconnect! if connected?
  end

  private

  def disconnect!
    @user.disconnects.create!(server_id: server.id, traffic_in: 0, traffic_out: 0)
  end

  def connected?
    @user.connected?
  end

  def server
    @user.connects.last.server
  end
end
