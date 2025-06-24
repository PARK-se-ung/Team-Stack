
    <style>
        .tab-menu {
            position: relative;
            display: flex;
            gap: 60px;
            font-size: 24px;
            font-weight: bold;
            color: #000;
            cursor: pointer;
        }

        .tab-item {
            position: relative;
            padding-bottom: 8px;
            z-index: 1; /* underline 보다 위 */
        }

        .tab-underline {
            position: absolute;
            bottom: -12px;
            left: 0;
            width: 0;
            height: 10px;
            background-color: #d88a16;
            border-radius: 10px;
            transition: left 0.3s ease, width 0.3s ease;
            z-index: 0;
        }
    </style>
</head>
<body>

<div class="tab-menu" id="tabMenu">
    <div class="tab-item active">수강중</div>
    <div class="tab-item">수강완료</div>
    <div class="tab-item">전체</div>
    <span class="tab-underline" id="underline"></span>
</div>

<script>
    document.addEventListener('DOMContentLoaded', () => {
        const tabs      = document.querySelectorAll('.tab-item');
        const underline = document.getElementById('underline');

        function moveUnderline(el) {
            underline.style.width  = el.offsetWidth + 'px';
            underline.style.left   = el.offsetLeft + 'px';
        }

        // 탭 클릭 이벤트
        tabs.forEach(tab => {
            tab.addEventListener('click', () => {
                document.querySelector('.tab-item.active').classList.remove('active');
                tab.classList.add('active');
                moveUnderline(tab);
            });
        });

        // 초기 위치 세팅
        moveUnderline(document.querySelector('.tab-item.active'));

        // (선택) 창 크기 바뀔 때도 다시 맞춰주기
        window.addEventListener('resize', () => {
            moveUnderline(document.querySelector('.tab-item.active'));
        });
    });
</script>
