module NotificationsHelper
  def notification_form(notification)
    # 通知を送ってきたユーザーを取得
    @visiter = notification.visiter
    # コメントの内容を通知に表示する
    @comment = nil
    your_work_out = link_to 'あなたの投稿', work_out_path(notification), style: 'font-weight: bold;'
    @visiter_comment = notification.comment_id
    # notification.actionがfollowかfavoirteかcommentかで処理を変える
    case notification.action
    when 'follow'
      "#{tag.a(notification.visiter.name, href: user_path(@visiter), style: 'font-weight: bold;')}があなたをフォローしました"
    when 'favorite'
      "#{tag.a(notification.visiter.name, href: user_path(@visiter), style: 'font-weight: bold;')}が#{tag.a('あなたの投稿', href: work_out_path(notification.work_out_id), style: 'font-weight: bold;')}にいいねしました"
    when 'comment'
      # コメントの内容を取得
      @comment = Comment.find_by(id: @visiter_comment)&.body
      "#{tag.a(@visiter.name, href: user_path(@visiter), style: 'font-weight: bold;')}が#{tag.a('あなたの投稿', href: work_out_path(notification.work_out_id), style: 'font-weight: bold;')}にコメントしました"
    end
  end

  def unchecked_notifications
    @notifications = current_user.passive_notifications.where(checked: false)
  end
end
