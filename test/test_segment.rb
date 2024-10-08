# frozen_string_literal: true

require 'minitest/autorun'
require 'cppjieba_rb'

class JiebaTest < Minitest::Test
  def test_mix_segment
    words = CppjiebaRb.segment '我来到南京市长江大桥'

    assert_equal %w[我 来到 南京市 长江大桥], words

    words = CppjiebaRb.segment '令狐冲是云计算行业的专家'

    assert_equal %w[令狐冲 是 云计算 行业 的 专家], words
  end

  def test_hmm_segment
    words = CppjiebaRb.segment '令狐冲是云计算行业的专家', mode: :hmm

    assert_equal %w[令狐冲 是 云计算 行业 的 专家], words
  end

  def test_max_prob_segment
    words = CppjiebaRb.segment '令狐冲是云计算行业的专家', mode: :mp

    assert_equal %w[令狐冲 是 云计算 行业 的 专家], words
  end
end
