# CppjiebaRb

[![Gem Version](https://badge.fury.io/rb/cppjieba_rb.svg)](http://badge.fury.io/rb/cppjieba_rb)

[![Build Status](https://travis-ci.org/fantasticfears/cppjieba_rb.png?branch=master)](https://travis-ci.org/fantasticfears/cppjieba_rb)

[![Patreon](https://img.shields.io/badge/back_on-patreon-red.svg)](https://www.patreon.com/fantasticfears)

Ruby bindings for [Cppjieba](https://github.com/yanyiwu/cppjieba). C++11 required. (gcc 4.8+)

## Installation

Add this line to your application's Gemfile:

    gem 'cppjieba_rb'

Or install it as:

    $ gem install cppjieba_rb

## Usage

Segmentation mode is described in cppjieba.

### Word segment Usage

Mix Segment mode (HMM with Max Prob, default):

```ruby
require 'cppjieba_rb'
seg = CppjiebaRb::Segment.new  # equivalent to "JiebaRb::Segment.new mode: :mix"
words = seg.segment "令狐冲是云计算行业的专家"
# 令狐冲 是 云 计算 行业 的 专家
```

The alternative convenient method:

```ruby
CppjiebaRb.segment('令狐冲是云计算行业的专家', mode: :mix)
```

HMM or Max probability (mp) Segment mode:

```ruby
seg = CppjiebaRb::Segment.new mode: :hmm # or  mode: :mp
seg.segment "令狐冲是云计算行业的专家"
```

### Word tagging Usage

```ruby
require 'cppjieba_rb'
CppjiebaRb.segment_tag "我是蓝翔技工拖拉机学院手扶拖拉机专业的。"
# [{"我"=>"r"}, {"是"=>"v"}, {"蓝翔"=>"x"}, {"技工"=>"n"}, {"拖拉机"=>"n"}, {"学院"=>"n"}, {"手扶拖拉机"=>"n"}, {"专业"=>"n"}, {"的"=>"uj"}, {"。"=>"x"}]
```

## Keyword Extractor Usage

```ruby
require 'cppjieba_rb'

CppjiebaRb.extract_keyword "我是拖拉机学院手扶拖拉机专业的。不用多久，我就会升职加薪，当上CEO，走上人生巅峰。", 5

# [
#   ["CEO", 11.739204307083542],
#   ["升职", 10.8561552143],
#   ["加薪", 10.642581114],
#   ["手扶拖拉机", 10.0088573539],
#   ["巅峰", 9.49395840471]
# ]
```

## Contributing

1. Fork it ( http://github.com/fantasticfears/cppjieba_rb/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

## TODO

- including 367w dict and provide the option for it.
- cppjieba implements trie tree, it's memory consuming