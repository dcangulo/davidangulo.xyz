# frozen_string_literal: true

Jekyll::Hooks.register :posts, :post_init do |post|
  commit_count = `git rev-list --count HEAD "#{post.path}"`.to_i

  next if commit_count < 1

  last_modified_date = `git log -1 --pretty="%ad" --date=iso "#{post.path}"`
  post.data['last_modified_at'] = last_modified_date
end
