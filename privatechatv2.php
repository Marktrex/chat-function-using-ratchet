<?php
session_start();
// print_r($_SESSION);
if (!isset($_SESSION['user_data'])) {
	header('location:index.php');
}

require ('database/ChatUser.php');
require ('database/ChatRooms.php');
?>
<!DOCTYPE html>
<html>

<head>
	<title>Chat application in PHP using WebSocket Programming</title>
	<!-- Tailwind CSS -->
	<link href="https://cdn.jsdelivr.net/npm/tailwindcss@2.0.0/dist/tailwind.min.css" rel="stylesheet">
	<!-- FontAwesome -->
	<link href="https://cdn.jsdelivr.net/npm/@fortawesome/fontawesome-free/css/all.min.css" rel="stylesheet">
	<!-- Parsley CSS -->
	<link rel="stylesheet" type="text/css" href="vendor-front/parsley/parsley.css" />
	<!-- jQuery -->
	<script src="vendor-front/jquery/jquery.min.js"></script>
	<!-- Parsley JS -->
	<script type="text/javascript" src="vendor-front/parsley/dist/parsley.min.js"></script>
	<style>
		html,
		body {
			height: 100%;
			width: 100%;
			margin: 0;
		}

		#messages_area {
			height: 75vh;
			overflow-y: auto;
		}
	</style>
</head>

<body class="bg-gray-100">
	<div class="flex h-screen">
		<!-- Sidebar -->
		<div class="w-1/4 bg-gray-200 border-r border-gray-300 overflow-y-auto p-4">
			<?php
			$login_user_id = '';
			$token = '';

			foreach ($_SESSION['user_data'] as $key => $value) {
				$login_user_id = $value['id'];
				$token = $value['token'];
				?>
				<input type="hidden" name="login_user_id" id="login_user_id" value="<?php echo $login_user_id; ?>" />
				<input type="hidden" name="is_active_chat" id="is_active_chat" value="No" />
				<div class="text-center mb-4">
					<img src="<?php echo $value['profile']; ?>" class="w-24 h-24 rounded-full mx-auto" />
					<h3 class="text-xl mt-2"><?php echo $value['name']; ?></h3>
					<a href="profile.php" class="block bg-gray-400 text-white py-2 px-4 rounded mt-2">Edit</a>
					<button type="button" class="bg-blue-500 text-white py-2 px-4 rounded mt-2 w-full"
						id="logout">Logout</button>
				</div>
				<?php
			}

			$user_object = new ChatUser;
			$user_object->setUserId($login_user_id);
			$user_data = $user_object->get_user_all_data_with_status_count();
			?>
			<div class="overflow-y-auto h-full">
				<?php foreach ($user_data as $key => $user) {
					if ($user['user_id'] != $login_user_id) {
						$total_unread_message = $user['count_status'] > 0 ? '<span class="bg-red-500 text-white text-xs font-semibold px-2 py-1 rounded-full">' . $user['count_status'] . '</span>' : '';
						?>
						<a class="flex items-center p-2 mb-2 rounded hover:bg-gray-300 cursor-pointer select_user"
							data-userid="<?php echo $user['user_id']; ?>">
							<img src="<?php echo $user["user_profile"]; ?>" class="w-12 h-12 rounded-full" />
							<div class="ml-3">
								<strong class="text-gray-800"><?php echo $user['user_name']; ?></strong>
								<div class="text-xs text-gray-500"><?php echo $total_unread_message; ?></div>
							</div>
						</a>
						<?php
					}
				} ?>
			</div>
		</div>
		<!-- Chat Area -->
		<div class="w-3/4 p-4 flex flex-col">
			<div class="flex-grow bg-white shadow-md rounded-lg p-4 flex flex-col">
				<div id="chat_area" class="flex flex-col h-full">
					<div id="messages_area" class="flex-1 overflow-y-auto mb-4">
						<!-- Messages will be appended here -->
					</div>
					<form id="chat_form" method="POST" class="flex">
						<textarea class="form-control w-full p-2 border rounded" id="chat_message" name="chat_message"
							placeholder="Type Message Here" data-parsley-maxlength="1000"
							data-parsley-pattern="/^[a-zA-Z0-9 ]+$/" required></textarea>
						<button type="submit" name="send" id="send"
							class="bg-blue-500 text-white py-2 px-4 rounded ml-2">
							<i class="fa fa-paper-plane"></i>
						</button>
					</form>
					<div id="validation_error" class="mt-2"></div>
				</div>
			</div>
		</div>
	</div>
	<script type="text/javascript">
		$(document).ready(function () {
			var receiver_userid = '';
			var conn = new WebSocket('ws://localhost:8080?token=<?php echo $token; ?>');

			conn.onopen = function (event) {
				console.log('Connection Established');
			};

			conn.onmessage = function (event) {
				var data = JSON.parse(event.data);

				if (data.status_type === 'Online') {
					$('#userstatus_' + data.user_id_status).html('<i class="fa fa-circle text-green-500"></i>');
				} else if (data.status_type === 'Offline') {
					$('#userstatus_' + data.user_id_status).html('<i class="fa fa-circle text-red-500"></i>');
				} else {
					var row_class = data.from === 'Me' ? 'flex justify-start' : 'flex justify-end';
					var background_class = data.from === 'Me' ? 'bg-blue-100' : 'bg-green-100';

					if (receiver_userid === data.userId || data.from === 'Me') {
						var html_data = `
					<div class="${row_class} mb-2">
						<div class="bg-white p-3 rounded shadow ${background_class}">
							<b>${data.from} - </b>${data.msg}
							<br />
							<div class="text-right text-xs text-gray-500">
								<small><i>${data.datetime}</i></small>
							</div>
						</div>
					</div>
					`;

						$('#messages_area').append(html_data);
						$('#messages_area').scrollTop($('#messages_area')[0].scrollHeight);
						$('#chat_message').val("");
					} else {
						var count_chat = $('#userid_' + data.userId).text();
						count_chat = count_chat === '' ? 0 : parseInt(count_chat);
						count_chat++;
						$('#userid_' + data.userId).html('<span class="bg-red-500 text-white text-xs font-semibold px-2 py-1 rounded-full">' + count_chat + '</span>');
					}
				}
			};

			conn.onclose = function (event) {
				console.log('connection close');
			};

			function make_chat_area(user_name) {
				var html = `
			<div class="flex flex-col h-full">
				<div class="flex-grow bg-white shadow-md rounded-lg p-4 flex flex-col">
					<div class="text-xl mb-4">Chat with <span class="text-red-500" id="chat_user_name">${user_name}</span></div>
					<div id="messages_area" class="flex-1 overflow-y-auto mb-4"></div>
					<form id="chat_form" method="POST" class="flex">
						<textarea class="form-control w-full p-2 border rounded" id="chat_message" name="chat_message" placeholder="Type Message Here" data-parsley-maxlength="1000" data-parsley-pattern="/^[a-zA-Z0-9 ]+$/" required></textarea>
						<button type="submit" name="send" id="send" class="bg-blue-500 text-white py-2 px-4 rounded ml-2">
							<i class="fa fa-paper-plane"></i>
						</button>
					</form>
					<div id="validation_error" class="mt-2"></div>
				</div>
			</div>
			`;
				$('#chat_area').html(html);
				$('#chat_form').parsley();
			}

			$(document).on('click', '.select_user', function () {
				receiver_userid = $(this).data('userid');
				var from_user_id = $('#login_user_id').val();
				var receiver_user_name = $('#list_user_name_' + receiver_userid).text();

				$('.select_user.active').removeClass('active');
				$(this).addClass('active');
				make_chat_area(receiver_user_name);
				$('#is_active_chat').val('Yes');

				$.ajax({
					url: "action.php",
					method: "POST",
					data: { action: 'fetch_chat', to_user_id: receiver_userid, from_user_id: from_user_id },
					dataType: "JSON",
					success: function (data) {
						if (data.length > 0) {
							var html_data = '';
							for (var count = 0; count < data.length; count++) {
								var row_class = data[count].from_user_id === from_user_id ? 'flex justify-start' : 'flex justify-end';
								var background_class = data[count].from_user_id === from_user_id ? 'bg-blue-100' : 'bg-green-100';
								var user_name = data[count].from_user_id === from_user_id ? 'Me' : data[count].from_user_name;

								html_data += `
							<div class="${row_class} mb-2">
								<div class="bg-white p-3 rounded shadow ${background_class}">
									<b>${user_name} - </b>
									${data[count].chat_message}
									<br />
									<div class="text-right text-xs text-gray-500">
										<small><i>${data[count].timestamp}</i></small>
									</div>
								</div>
							</div>
							`;
							}
							$('#userid_' + receiver_userid).html('');
							$('#messages_area').html(html_data);
							$('#messages_area').scrollTop($('#messages_area')[0].scrollHeight);
						}
					}
				});
			});

			$(document).on('submit', '#chat_form', function (event) {
				event.preventDefault();
				if ($('#chat_form').parsley().isValid()) {
					var user_id = parseInt($('#login_user_id').val());
					var message = $('#chat_message').val();
					var data = {
						userId: user_id,
						msg: message,
						receiver_userid: receiver_userid,
						command: 'private'
					};
					conn.send(JSON.stringify(data));
				}
			});

			$(document).on('click', '#logout', function () {
				var user_id = $('#login_user_id').val();
				$.ajax({
					url: "action.php",
					method: "POST",
					data: { user_id: user_id, action: 'leave' },
					success: function (data) {
						var response = JSON.parse(data);
						if (response.status === 1) {
							conn.close();
							location = 'index.php';
						}
					}
				});
			});
		});
	</script>

</body>

</html>