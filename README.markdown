# rspec-formatter-vim

RSpec2 formatter to make it easy to parse using vim's quickfix compiler.

This formatter was inspired by tpope's amazing vim-dispatch plugin. In the example video (http://vimeo.com/63116209) he shows a combination of vim-dispatch and the rspec compiler from vim-rails. This is an attempt to get a similar result using rspec2 (although the output is slightly different).

## Screenshot

![Screenshot of rspec-formatter-vim in action](screenshot.png)

## Installation

Add the gem to your Gemfile:

    group :test do
      gem "rspec-rails", '~> 2.13.0'
      gem "rspec-formatter-vim", '~> 0.1.0'
    end

Add a compiler to vim. I created ~/.vim/compiler/rspec2.vim and added the following content (adapter from the rspec compiler included in vim-rails):

    " Vim compiler file
    " Language:		RSpec2
    " Maintainer:		John Cinnamond
    " Last Change:		2013-04-07

    if exists("current_compiler")
      finish
    endif
    let current_compiler = "rspec2"

    if exists(":CompilerSet") != 2		" older Vim always used :setlocal
      command -nargs=* CompilerSet setlocal <args>
    endif

    let s:cpo_save = &cpo
    set cpo-=C

    CompilerSet makeprg=bundle\ exec\ rspec\ -f\ VimFormatter

    CompilerSet errorformat=
          \F:%f:%l:%m,
          \P:%f:%l:%m

    let &cpo = s:cpo_save
    unlet s:cpo_save

    " vim: nowrap sw=2 sts=2 ts=8:

Tell vim to use the rspec2 compiler. I adapted the example from https://github.com/tpope/vim-rails:

    autocmd FileType ruby
          \ if expand('%') =~# '_spec\.rb$' |
          \   compiler rspec2 | setl makeprg=rspec\ -f\ VimFormatter\ \"%:p\" |
          \ else |
          \   compiler ruby | setl makeprg=ruby\ -wc\ \"%:p\" |
          \ endif
    autocmd User Bundler
          \ if &makeprg !~# 'bundle' | setl makeprg^=bundle\ exec\  | endif

Enjoy vim+rspec+vim-dispatch awesomeness.

## Contributing to rspec-formatter-vim
 
* Check out the latest master to make sure the feature hasn't been implemented or the bug hasn't been fixed yet.
* Check out the issue tracker to make sure someone already hasn't requested it and/or contributed it.
* Fork the project.
* Start a feature/bugfix branch.
* Commit and push until you are happy with your contribution.
* Make sure to add tests for it. This is important so I don't break it in a future version unintentionally.
* Please try not to mess with the Rakefile, version, or history. If you want to have your own version, or is otherwise necessary, that is fine, but please isolate to its own commit so I can cherry-pick around it.

## Copyright

Copyright (c) 2013 John Cinnamond. See LICENSE.txt for further details.

