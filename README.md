# flutter

## 功能页面

> 撰写文档看华子哥情况
>
- 大致页面：登录注册，文件列表，文件预览，用户信息，文件上传

## 抓 API

> Todo
- 核心接口：/api/public/path 抓取文件列表和访问链接
    - Payload：

        ```json
        page_num: 1
        page_size: 30
        password: ""
        path: "/share/Document/effective-resourses/JavaScript"
        ```

    - Resp：

        ```json
        {
            "code": 200,
            "message": "success",
            "data": {
                "type": "folder",
                "meta": {
                    "driver": "AliDrive",
                    "upload": false,
                    "total": 13
                },
                "files": [
                    {
                        "name": "你不知道的 JavaScript（下卷）_ocr.pdf",
                        "size": 7322231,
                        "type": 2,
                        "driver": "AliDrive",
                        "updated_at": "2022-03-29T07:59:31.391Z",
                        "thumbnail": "https://ccp-bj29-video-preview.oss-cn-beijing.aliyuncs.com/OfficeThumbnail%2F5fb3ec170bf4b884a9254ae98762078f0048860a%2F5fb3ec1709e69d395d8f44669c67c1e8577f680a%2F1.jpg?x-oss-access-key-id=LTAIsE5mAn2F493Q&x-oss-expires=1648557105&x-oss-process=image%2Fresize%2Cm_mfit%2Cw_256%2Climit_0&x-oss-signature=R3yB8YvgeYY32kVJt0t1lu%2Bh7uyMApXvtnz%2F0VgLHEQ%3D&x-oss-signature-version=OSS2",
                        "url": "https://bj29.cn-beijing.data.alicloudccp.com/5fb3ec170bf4b884a9254ae98762078f0048860a%2F5fb3ec1709e69d395d8f44669c67c1e8577f680a?di=bj29&dr=70890063&f=6242ba3a5b8c1006c9c0423cb53b6afeb44990df&u=f3828f795437491db48caf046f03e98f&x-oss-access-key-id=LTAIsE5mAn2F493Q&x-oss-expires=1648557105&x-oss-signature=uvifhGUgsQqA7Q4YiMIsHcTe0dOlqI3ornvdScSHkEs%3D&x-oss-signature-version=OSS2",
                        "size_str": "",
                        "time_str": ""
                    },
                    {
                        "name": "《深入理解ES6》.pdf",
                        "size": 173973943,
                        "type": 2,
                        "driver": "AliDrive",
                        "updated_at": "2022-03-29T07:59:31.389Z",
                        "thumbnail": "https://ccp-bj29-video-preview.oss-cn-beijing.aliyuncs.com/OfficeThumbnail%2F5fe576fc7573803f494b400f9a9ccb1e13cca588%2F5fe576fc7f362f1cb5de49f283471c120a2cf553%2F1.jpg?x-oss-access-key-id=LTAIsE5mAn2F493Q&x-oss-expires=1648557105&x-oss-process=image%2Fresize%2Cm_mfit%2Cw_256%2Climit_0&x-oss-signature=AWQtkxPLfI7wRJvgxVotlEGQNkfSlfXNgOTRuoRFHZY%3D&x-oss-signature-version=OSS2",
                        "url": "https://bj29.cn-beijing.data.alicloudccp.com/5fe576fc7573803f494b400f9a9ccb1e13cca588%2F5fe576fc7f362f1cb5de49f283471c120a2cf553?di=bj29&dr=70890063&f=6242b9844c5c5e38087e4ee6ac1836ef09128b7b&u=f3828f795437491db48caf046f03e98f&x-oss-access-key-id=LTAIsE5mAn2F493Q&x-oss-expires=1648557105&x-oss-signature=JXQbLacrVG41ckqoCpJeO8gfYL%2B0xri4yQNAv2pdqHI%3D&x-oss-signature-version=OSS2",
                        "size_str": "",
                        "time_str": ""
                    }
                ]
            }
        }
        ```