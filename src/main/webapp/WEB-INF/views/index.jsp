<%@ page language="java" contentType="text/html;charset=utf-8"%>
<jsp:include page="/WEB-INF/views/common/header.jsp"/>
    <!-- section -->
    <section class="main-container">
        <div class="category">
            <button class="btn btn-outline-orange me-3">국어</button>
            <button class="btn btn-outline-orange me-3">수학</button>
            <button class="btn btn-outline-orange me-3">영어</button>
            <button class="btn btn-outline-orange me-3">사회</button>
            <button class="btn btn-outline-orange me-3">과학</button>
            <button class="btn btn-outline-orange me-3">체육</button>
            <button class="btn btn-outline-orange me-3">음악</button>
            <button class="btn btn-outline-orange me-3">미술</button>
        </div>
        <div class="list">
            <h3>최근 본 강의 </h3>
            <div class="image-container">
                <div class="blank">
                    <p>조회된 결과가 없습니다.</p>
                </div>
            </div>
        </div>
        <div class="list">
            <h3>초등학교</h3>
            <div class="image-container">
                <div class="card" style="width: 18rem;">
                    <a href="${pageContext.request.contextPath}/course/details?courseNo=${course.courseNo}">
                        <img src="${pageContext.request.contextPath}/resources/upload/${course.thumbnail}" class="card-img-top" alt="썸네일">
                        <div class="card-body">
                            ${course.courseTitle}
                        </div>
                    </a>
                </div>
                <div class="image-card">
                    <img src="/WEB-INF/resources/images/logo.png" width="100px" height="120px" alt="python">
                    <span>category | title</span>
                </div>
                <div class="image-card">
                    <img src="/WEB-INF/resources/images/logo.png" width="100px" height="120px" alt="python">
                    <span>category | title</span>
                </div>
                <div class="image-card">
                    <img src="/WEB-INF/resources/images/logo.png" width="100px" height="120px" alt="python">
                    <span>category | title</span>
                </div>
                <div class="image-card">
                    <img src="/WEB-INF/resources/images/logo.png" width="100px" height="120px" alt="python">
                    <span>category | title</span>
                </div><div class="image-card">
                    <img src="/WEB-INF/resources/images/logo.png" width="100px" height="120px" alt="python">
                    <span>category | title</span>
                </div>
                <div class="image-card">
                    <img src="/WEB-INF/resources/images/logo.png" width="100px" height="120px" alt="python">
                    <span>category | title</span>
                </div>
                <div class="image-card">
                    <img src="/WEB-INF/resources/images/logo.png" width="100px" height="120px" alt="python">
                    <span>category | title</span>
                </div>
                <div class="image-card">
                    <img src="/WEB-INF/resources/images/logo.png" width="100px" height="120px" alt="python">
                    <span>category | title</span>
                </div>
            </div>
        </div>
        <div class="list">
            <h3>중학교</h3>
            <div class="image-container">
                <div class="image-card">
                    <img src="./logo.png" width="100px" height="120px" alt="python">
                    <span>category | title</span>
                </div>
                <div class="image-card">
                    <img src="./logo.png" width="100px" height="120px" alt="python">
                    <span>category | title</span>
                </div>
                <div class="image-card">
                    <img src="./logo.png" width="100px" height="120px" alt="python">
                    <span>category | title</span>
                </div>
                <div class="image-card">
                    <img src="./logo.png" width="100px" height="120px" alt="python">
                    <span>category | title</span>
                </div>
                <div class="image-card">
                    <img src="./logo.png" width="100px" height="120px" alt="python">
                    <span>category | title</span>
                </div>
                <div class="image-card">
                    <img src="./logo.png" width="100px" height="120px" alt="python">
                    <span>category | title</span>
                </div>
                <div class="image-card">
                    <img src="./logo.png" width="100px" height="120px" alt="python">
                    <span>category | title</span>
                </div>
                <div class="image-card">
                    <img src="./logo.png" width="100px" height="120px" alt="python">
                    <span>category | title</span>
                </div>
            </div>
        </div>
        <div class="list">
            <h3>고등학교</h3>
            <div class="image-container">
                <div class="image-card">
                    <img src="./logo.png" width="100px" height="120px" alt="python">
                    <span>category | title</span>
                </div>
                <div class="image-card">
                    <img src="./logo.png" width="100px" height="120px" alt="python">
                    <span>category | title</span>
                </div>
                <div class="image-card">
                    <img src="./logo.png" width="100px" height="120px" alt="python">
                    <span>category | title</span>
                </div>
                <div class="image-card">
                    <img src="./logo.png" width="100px" height="120px" alt="python">
                    <span>category | title</span>
                </div>
                <div class="image-card">
                    <img src="./logo.png" width="100px" height="120px" alt="python">
                    <span>category | title</span>
                </div>
                <div class="image-card">
                    <img src="./logo.png" width="100px" height="120px" alt="python">
                    <span>category | title</span>
                </div>
                <div class="image-card">
                    <img src="./logo.png" width="100px" height="120px" alt="python">
                    <span>category | title</span>
                </div>
                <div class="image-card">
                    <img src="./logo.png" width="100px" height="120px" alt="python">
                    <span>category | title</span>
                </div>
            </div>
        </div>
    </section>

<jsp:include page="/WEB-INF/views/common/footer.jsp"/>