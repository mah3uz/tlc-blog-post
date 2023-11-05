#!/usr/bin/env bash

# Find mdx file in the current directory recursively
# and append the following lines to the start of the file

files=$(find . -type f -name "*.md")

for file in $files; do
  random_number=$((RANDOM % 800 + 370))
  random_date=$(date -v -${random_number}d +%Y-%m-%dT%H:%M:%S-0400)
  filename=$(echo "$file" | awk -F'/' '{print $2}' | sed 's/-/ /g')

  header_text="import Image from 'next/image'
import postImage from './postImage.jpg'
import BlogPost from '@/components/BlogPost'
import {users} from '@/utils/constant'

export const article = {
  title: '${filename}',
  description: 'description',
  publishedOn: '${random_date}',
  image: postImage,
  category: 'medical',
  author: users.tim,
}

export const metadata = {
  title: article.title,
  description: article.description,
}

export default (props) => <BlogPost post={article} {...props} />

<Image src={postImage} alt={article.title} />
"

  echo -e "$header_text\n$(cat "$file")" > "$file"
done
