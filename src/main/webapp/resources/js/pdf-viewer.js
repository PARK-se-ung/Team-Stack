import * as pdfjsLib from './pdf/build/pdf.mjs';

export function initPdfViewer({
                                  url,
                                  canvasId,
                                  prevBtnId,
                                  nextBtnId,
                                  pageInfoId,
                                  scale = 1.5
                              }) {
    let pdfDoc = null;
    let pageNum = 1;
    let pageCount = 0;
    let isRendering = false;

    const canvas = document.getElementById(canvasId);
    const ctx = canvas.getContext('2d');

    const renderPage = (num) => {
        isRendering = true;

        pdfDoc.getPage(num).then(page => {
            const viewport = page.getViewport({ scale });
            canvas.height = viewport.height;
            canvas.width = viewport.width;

            return page.render({ canvasContext: ctx, viewport }).promise;
        }).then(() => {
            isRendering = false;
            document.getElementById(pageInfoId).textContent = `${pageNum} / ${pageCount}`;
        });
    };

    document.getElementById(prevBtnId)?.addEventListener('click', () => {
        if (pageNum <= 1 || isRendering) return;
        pageNum--;
        renderPage(pageNum);
    });

    document.getElementById(nextBtnId)?.addEventListener('click', () => {
        if (pageNum >= pageCount || isRendering) return;
        pageNum++;
        renderPage(pageNum);
    });

    pdfjsLib.getDocument(url).promise.then(pdf => {
        pdfDoc = pdf;
        pageCount = pdf.numPages;
        renderPage(pageNum);
    }).catch(err => {
        console.error('PDF 로딩 실패:', err);
    });
}
