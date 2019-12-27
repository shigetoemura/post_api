module Exceptions
	class NotHaveAuthForUpdateError < StandardError; end
	class AlreadyFavoritesError < StandardError; end
	class NotFavoritesYetError < StandardError; end
end