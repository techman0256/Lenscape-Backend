db = Mongoid.default_client

stories_data = [
  {
    user_id: '678631ee4192cbf995fd5c0d',
    type: 'image',
    urls: ['https://picsum.photos/1080/1920'],
    duration: 5,
    header: {
      heading: 'John Doe',
      subheading: 'Posted 5 minutes ago',
      profileImage: 'https://picsum.photos/100/100'
    },
    created_at: 5.minutes.ago
  },
  {
    user_id: '6786621d1ece735896886e04',
    type: 'image',
    urls: ['https://picsum.photos/1080/1920'],
    duration: 5,
    header: {
      heading: 'Jane Smith',
      subheading: 'Posted 10 minutes ago',
      profileImage: 'https://picsum.photos/100/100'
    },
    created_at: 10.minutes.ago
  },
  {
    user_id: '678631ee4192cbf995fd5c0d',
    type: 'image',
    urls: ['https://picsum.photos/1080/1920'],
    duration: 6,
    header: {
      heading: 'Alice Johnson',
      subheading: 'Posted 15 minutes ago',
      profileImage: 'https://picsum.photos/100/100'
    },
    created_at: 15.minutes.ago
  }
]

stories_data.each do |story|
  db[:stories].insert_one(story)
end
