# frozen_string_literal: true

require 'minitest/autorun'
require 'cppjieba_rb'

class JiebaTest < Minitest::Test
  def test_filter
    words = CppjiebaRb.filter_stop_word %w[令狐冲 是 云计算 行业 的 专家]

    assert_equal %w[令狐冲 云计算 行业 专家], words
  end
end
