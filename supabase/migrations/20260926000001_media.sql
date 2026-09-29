-- Public media for posts and events (flyers, photos). `posts.image_url` may be
-- a full URL or a path inside this bucket, e.g. 'events/DceUV6YNJC-.jpg'.
insert into storage.buckets (id, name, public, file_size_limit, allowed_mime_types)
values ('media', 'media', true, 10485760, array['image/jpeg', 'image/png', 'image/webp'])
on conflict (id) do nothing;

create policy media_manage_insert on storage.objects for insert to authenticated
  with check (bucket_id = 'media' and is_manager());
create policy media_manage_update on storage.objects for update to authenticated
  using (bucket_id = 'media' and is_manager());
create policy media_manage_delete on storage.objects for delete to authenticated
  using (bucket_id = 'media' and is_manager());
