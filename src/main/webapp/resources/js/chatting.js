
function parameterParser(){
    const param=location.search;
    const paramObj=param.substring(param.indexOf("?")+1)
                        .split("&")
                        .reduce((prev,next)=>{
                           const p=next.split("=")
                           prev[p[0]]=p[1]
                           return prev;
                        },{});
    return paramObj;
}
function connectionChatting(userId){
    let paramObj=parameterParser();
    const socket = new WebSocket("wss://13.124.190.205/teamstack/chat?courseNo="+paramObj['courseNo']);
    const sendMessage =  function () {
        console.log("✅ [클릭됨] sendMessage 실행됨"); // ⬅ 이거 무조건 넣자

        const input = document.getElementById("chat-input");
        const message = input.value.trim();

        if (message !== "" && socket.readyState === WebSocket.OPEN) {
            // JSON 형태로 사용자 정보와 메시지를 함께 전송
            const messageData = {
                userId: userId,
                chatMsg: message,
                courseNo: parseInt(paramObj["courseNo"])
        };

            socket.send(JSON.stringify(messageData));
            input.value = "";
        }
    }

    document.getElementById('send-btn').addEventListener('click', sendMessage);


    // 브라우저 WebSocket 연결을 생성하는 JavaScript 객체

    socket.onmessage = function(event){
        console.log("sendMessage 함수 호출됨!");
        // 메시지가 오면 발생
        const chat = JSON.parse(event.data);
        const chatBox = document.getElementById('chat-box');
        const $div = document.createElement('div');
        $div.classList.add("mb-2");

        if (chat.userId === currentUserId) {
            $div.innerHTML =
                '<div class="message-bubble own-message">' +
                '<div class="message-header">' +
                '<span class="message-author">나</span>' +
                '<span class="message-time">(' + chat.chatTime + ')</span>' +
                '</div>' +
                '<div class="message-content">' + chat.chatMsg + '</div>' +
                '</div>';
        } else {
            $div.innerHTML =
                '<div class="message-bubble">' +
                '<div class="message-header">' +
                '<span class="message-author">' + chat.userId + '</span>' +
                '<span class="message-time">(' + chat.chatTime + ')</span>' +
                '</div>' +
                '<div class="message-content">' + chat.chatMsg + '</div>' +
                '</div>';
        }

        // 5️⃣ 화면에 메시지 추가
        chatBox.appendChild($div);
        chatBox.scrollTop = chatBox.scrollHeight; // 자동 스크롤
    };
}
