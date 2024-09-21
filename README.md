# CppjiebaRb

[![Gem Version](https://badge.fury.io/rb/cppjieba_rb.svg)](http://badge.fury.io/rb/cppjieba_rb)

Ruby bindings for [Cppjieba](https://github.com/yanyiwu/cppjieba). C++11 required. (gcc 4.8+)

The TRIE tree has high memory usage. For default dict, it uses ~120 MB memory.

## Installation

Add this line to your application's Gemfile:

    gem 'cppjieba_rb', require: false

Or pin a version:

    gem 'cppjieba_rb', '~> 0.4.4', require: false

Or install it as:

    $ gem install cppjieba_rb

## Usage

Segmentation mode is described in cppjieba.

### Word segment Usage

Mix Segment mode (HMM with Max Prob, default):

```ruby
require 'cppjieba_rb'

seg = CppjiebaRb::Segment.new  # equivalent to "CppjiebaRb::Segment.new(mode: :mix)"
words = seg.segment("令狐冲是云计算行业的专家")
# ["令狐冲", "是", "云计算", "行业", "的", "专家"]
```

The alternative convenient method:

```ruby
CppjiebaRb.segment('令狐冲是云计算行业的专家', mode: :mix)
```

HMM or Max probability (mp) Segment mode:

```ruby
seg = CppjiebaRb::Segment.new(mode: :hmm_ # or  mode: :mp
seg.segment("令狐冲是云计算行业的专家")
```

### Word tagging Usage

```ruby
require 'cppjieba_rb'

CppjiebaRb.segment_tag("《忍者蝙蝠侠》续集《忍者蝙蝠侠vs极道联盟》发布角色预告片。")
# {"《"=>"x", "忍者"=>"n", "蝙蝠侠"=>"n", "》"=>"x", "续集"=>"v", "vs"=>"eng", "极道"=>"x", "联盟"=>"j", "发布"=>"v", "角色"=>"n", "预告片"=>"n", "。"=>"x"}
```

## Keyword Extractor Usage

```ruby
require 'cppjieba_rb'

CppjiebaRb.extract_keyword("山西退沙村的明代鼓楼，在今年初被拆掉了。", 5)

# [
#    ["退沙村", 11.739204307083542],
#    ["拆掉", 9.65218240993],
#    ["鼓楼", 9.37888907493],
#    ["今年初", 8.89004235788],
#    ["明代", 6.52667579263]
# ]
```

## Contributing

1. Fork it ( http://github.com/erickguan/cppjieba_rb/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

## TODO

- including 367w dict and provide the option for it.
- cppjieba implements trie tree, it's memory consuming
