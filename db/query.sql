-- Find assignment submissions by email

select lessons.title, assignments.due_on, submissions.public, users.email
  from assignments
join lessons on lessons.id = assignments.lesson_id
join submissions on submissions.lesson_id = lessons.id
join users on users.id = submissions.user_id
where users.email = 'rdavis.bacs@gmail.com';


-- Find comments made by admins on assignments

select lessons.title, assignments.due_on, submissions.public,
  comments.line_number, submitters.email, commenters.email
  from assignments
join lessons on lessons.id = assignments.lesson_id
join submissions on submissions.lesson_id = lessons.id
join comments on comments.submission_id = submissions.id
join users as commenters on commenters.id = comments.user_id
join users as submitters on submitters.id = submissions.user_id
where commenters.role = 'admin' and lessons.title = 'Grocery List';
