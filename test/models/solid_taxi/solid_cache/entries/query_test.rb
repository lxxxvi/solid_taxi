require "test_helper"

class SolidTaxi::SolidCache::Entries::QueryTest < ActiveSupport::TestCase
  test "#scope, all" do
    with_params do |query|
      assert_equal 30, query.scope.count
    end
  end

  test "#scope, key_hash, exact" do
    with_query_params(key_hash: "-6671586149898165518") do |query|
      assert_equal 1, query.scope.count
      assert_includes query.scope, solid_cache_entries(:player_001_score)
    end

    with_query_params(key_hash: "1") do |query|
      assert_equal 0, query.scope.count
    end
  end

  test "#scope, byte_size, number range" do
    with_query_params(byte_size_from: "183", byte_size_to: "184") do |query|
      assert_equal 30, query.scope.count
    end

    with_query_params(byte_size_to: "182") do |query|
      assert_equal 0, query.scope.count
    end

    with_query_params(byte_size_from: "184") do |query|
      assert_equal 0, query.scope.count
    end
  end

  test "#scope, created_at, time range" do
    with_query_params(created_at_from: "2026-08-01T00:58") do |query|
      assert_equal 1, query.scope.count
      assert_includes query.scope, solid_cache_entries(:player_030_score)
    end

    with_query_params(created_at_to: "2026-08-01T00:03") do |query|
      assert_equal 1, query.scope.count
      assert_includes query.scope, solid_cache_entries(:player_001_score)
    end

    with_query_params(
      created_at_from: "2026-08-01T00:32",
      created_at_to: "2026-08-01T00:36"
    ) do |query|
      assert_equal 2, query.scope.count
      assert_includes query.scope, solid_cache_entries(:player_017_score)
      assert_includes query.scope, solid_cache_entries(:player_018_score)
    end
  end

  private

  def with_params(**args)
    params = ActionController::Parameters.new(args)
    query = SolidTaxi::SolidCache::Entries::Page.new(params).query

    yield query
  end

  def with_query_params(**args, &)
    with_params(query: args, &)
  end
end
