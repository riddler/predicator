require "helper"

module Predicator
  class TestMemoryRepo < Minitest::Test
    def setup
      @repo = MemoryRepo.new
    end

    def test_find_unknown_predicate
      assert_raises PredicateNotFoundError do
        @repo.find_by_name "good_credit"
      end
    end

    def test_create
      assert_equal 0, @repo.size
      predicate = @repo.create name: "good_credit", source: "score > 700"
      assert_equal 1, @repo.size
      assert_kind_of MemoryPredicate, predicate
    end

    def test_create_generates_instructions
      predicate = @repo.create name: "good_credit", source: "score > 700"
      refute_nil predicate.instructions
    end

    def test_find_by_name
      predicate = @repo.create name: "good_credit", source: "score > 700"
      found = @repo.find_by_name "good_credit"
      assert_equal predicate, found
    end
  end
end
