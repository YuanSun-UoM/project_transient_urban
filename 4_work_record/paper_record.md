[call for paper](https://agupubs.onlinelibrary.wiley.com/hub/journal/19422466/homepage/call-for-papers/si-2023-000489)

## First submit

## Data storage

- Sunyuan531521!

````
cd /mnt/eps01-rds/zheng_medal/yuansun/project1

# data transfer from archer2 to csf3 RDS
# for example
scp -r yuansun@login.archer2.ac.uk:/mnt/lustre/a2fs-work2/work/n02/n02/yuansun/cesm/archive/Case6_1/rest/* a16404ys@csf3.itservices.manchester.ac.uk:/mnt/eps01-rds/zheng_medal/yuansun/project1/case/ROOF_IMPRAOD_TV/restart

# back data in Jasmin

````

## Figure size

print(115/25.4, 95/25.4, 230/25.4, 190/25.4)

```
高：4.52755905511811 宽：3.7401574803149606 9.05511811023622 7.480314960629921

figsize=(5.5, 1.75) nrows=1, ncols=3
nrows=2, ncols=3, figsize=(5.5, 2.5)
nrows=4, ncols=3, figsize=(5.5, 4)
140/25.4 = 5.5
```

# Revise

```
Strictly speaking, albedo is defined as the ratio of reflected solar radiation to incoming radiation.  The effects on absorbed solar radiation is a consequence of that.
```

```
I don't think ESMs have an advantage in representing interactions between the atmosphere and urban areas.  In fact, regional models, because they are typically run at higher spatial resolution than ESMs, are more likely to represent two-way interactions between the atmosphere and urban areas.
```

```
The pervious surfaces in the urban model are basically just bare soil with a soil moisture store sufficient for evaporation.  There aren't any "natural" characteristics of vegetation in the urban model.  The albedo is set to that of a typical vegetated surface.  Maybe simply say the the scheme is focused on built surfaces and leave it at that.
```

```
# FGR is the urban heat flux into soil/snow
# change to: 
This might be a bit confusing for readers, might be better to say the heat flux into urban surfaces since it includes roofs/wall/road.
```

```
We don't really model ice in urban area per se, so I'd just say snow here.

# in urban areas, CLMU modeled snow but not modeled ice.
```

```
# change from:
SUHII turns to be negative since 2043.

# to:
SUHII becomes negative beginning in 2043
```



# Sharing data

## dropbox sharing

```
export PATH="/work/n02/n02/yuansun/privatemodules_packages/rclone/rclone-v1.62.2-linux-amd64:$PATH"

rclone copy /work/n02/n02/yuansun/cesm/runs/0project1/cp_dyn_n6/ dropbox:Archer2/transient_albedo/case/computation_performance/cp_dyn_n6
```



## figshare

- [UoM figshare](https://www.library.manchester.ac.uk/services/research/research-data-management/sharing/#d.en.694900)

  - contact e-mail: researchdata@manchester.ac.uk

  ```
  Dear Yuan,
   
  Thanks for getting in touch. To help you decide on the most appropriate place to publish your data, I would recommend taking a look at the AGU guidance on their Data & Software for Authors page, as well as the guidance available on our Library website regarding repositories.
   
  If after reviewing these resources your preference is to use our institutional repository on Figshare, then you would need to submit a request to increase your storage allowance. Requests of up to 250GB can be made through your UoM Figshare account, by going to the 'My Data' tab and clicking on 'Request more storage'. If you require more than 250GB then you would need to contact us at researchdata@manchester.ac.uk, indicating exactly how much storage would be required and providing some further details and context to help us consider the request.
   
  I hope this helps, please do let me know if you have any further questions.
   
  Best wishes,
   
  Kirsten
  ```


- transfer data from Archer2 to figshare using API


  - [ API documentation](https://docs.figshare.com/#), 最底部有各种功能的定义，用于理解
  - [Figshare User Documentation](https://docs.figshare.com/old_docs/)

  ```
  # Figshare FTO login details
  # username: 4034363
  # password Sunyuan531521!
  
  # figshare personal token
  f6ddeeb2f06f3a418c958d93b08e6ed501405d41ba90321069d49704fd61e9f846c06132e5756817c684db915f8b96b8cfcade2c57b81ba38e5c84537dc7bb1f
  
  # 检查figshare信息
  curl -X GET "https://api.figshare.com/v2/account" -H "Authorization: token f6ddeeb2f06f3a418c958d93b08e6ed501405d41ba90321069d49704fd61e9f846c06132e5756817c684db915f8b96b8cfcade2c57b81ba38e5c84537dc7bb1f"
  # returns: 
  [{"message": "Missing OAuth token", "code": "OAuthMissingToken"}(myvenv) (base) yuansun@ln02:/work/n02/n02/yuansun> curl -X GET "httpsb2f06f3a418c958d93b08e6ed501405d41ba90321069d49704fd61e9f846c06132e5756817c684db915f8b96b8cfcade2c57b81ba38e5c84537dc7bb1f"
  {"created_date": "2024-02-01T15:11:01Z", "modified_date": "2024-11-20T14:13:04Z", "group_id": 0, "quota": 21474836480, "maximum_file_size": 21474836480, "used_quota": 539490, "used_quota_private": 539490, "used_quota_public": 0, "pending_quota_request": false, "id": 4034363, "first_name": "Yuan", "last_name": "Sun", "email": "sunyuanzju@outlook.com", "active": 1, "institution_user_id": "", "user_id": 17888210, "orcid_id": "0000-0003-2342-1281"}]
  
  curl -X GET "https://api.figshare.com/v2/account/projects" -H "Authorization: token f6ddeeb2f06f3a418c958d93b08e6ed501405d41ba90321069d49704fd61e9f846c06132e5756817c684db915f8b96b8cfcade2c57b81ba38e5c84537dc7bb1f"
  # returns:
  [{"storage": "group", "role": "Collaborator", "id": 227034, "title": "CESM Transient Urban Surface Albedo Representation", "url": "https://api.figshare.com/v2/account/projects/227034", "created_date": "2024-11-08T01:13:34Z", "published_date": null, "modified_date": "2024-11-20T13:19:27Z"}]
  
  curl -X GET "https://api.figshare.com/v2/account/projects/227034" -H "Authorization: token f6ddeeb2f06f3a418c958d93b08e6ed501405d41ba90321069d49704fd61e9f846c06132e5756817c684db915f8b96b8cfcade2c57b81ba38e5c84537dc7bb1f"
  # returns 
  {"group_id": 29358, "quota": 128849018880, "used_quota": 63104, "used_quota_private": 63104, "used_quota_public": 0, "created_date": "2024-11-08T01:13:34Z", "modified_date": "2024-11-20T13:19:27Z", "published_date": null, "custom_fields": [{"is_mandatory": false, "field_type": "textarea", "settings": {"validations": {"min_length": 5, "max_length": 1000}, "placeholder": "Year-00000-00000"}, "name": "Research ethics approval number", "value": ""}], "account_id": 4647526, "storage": "group", "role": "Collaborator", "id": 227034, "title": "CESM Transient Urban Surface Albedo Representation", "url": "https://api.figshare.com/v2/account/projects/227034", "description": "<p>In this study, we developed a new transient urban surface albedo scheme in the Community Earth System Model and evaluated evolving adaptation strategies under varying urban surface albedo configurations. Our simulations model a gradual increase in the urban surface albedo of roofs, impervious roads, and walls from 2015 to 2099 under the SSP3-7.0 scenario.</p>", "funding": null, "funding_list": [], "collaborators": [{"user_id": 17888210, "name": "Yuan Sun", "role_name": "Collaborator"}, {"user_id": 19728268, "name": "Zhonghua Zheng", "role_name": "Owner"}], "figshare_url": null}
  
  curl -X GET "https://api.figshare.com/v2/account/projects/227034/articles/" -H "Authorization: token f6ddeeb2f06f3a418c958d93b08e6ed501405d41ba90321069d49704fd61e9f846c06132e5756817c684db915f8b96b8cfcade2c57b81ba38e5c84537dc7bb1f"
  # returns
  [{"created_date": "2024-11-20T13:19:27Z", "modified_date": "2024-11-20T14:13:04Z", "id": 27867357, "title": "Improving Urban Climate Adaptation Modeling in the Community Earth System Model (CESM) Through Transient Urban Surface Albedo Representation", "doi": "", "handle": "", "url": "https://api.figshare.com/v2/account/projects/227034/articles/27867357", "published_date": null, "thumb": "", "defined_type": 3, "defined_type_name": "dataset", "group_id": 29358, "url_private_api": "https://api.figshare.com/v2/account/articles/27867357", "url_public_api": "https://api.figshare.com/v2/articles/27867357", "url_private_html": "https://figshare.com/account/articles/27867357", "url_public_html": "https://figshare.manchester.ac.uk/articles/dataset/_/27867357", "timeline": {}, "resource_title": null, "resource_doi": null}]
   
  curl -X GET "https://api.figshare.com/v2/account/projects/227034/articles/27867357" -H "Authorization: token f6ddeeb2f06f3a418c958d93b08e6ed501405d41ba90321069d49704fd61e9f846c06132e5756817c684db915f8b96b8cfcade2c57b81ba38e5c84537dc7bb1f"
  
  curl -X GET "https://api.figshare.com/v2/account/projects/227034/articles/27867357/files" -H "Authorization: token f6ddeeb2f06f3a418c958d93b08e6ed501405d41ba90321069d49704fd61e9f846c06132e5756817c684db915f8b96b8cfcade2c57b81ba38e5c84537dc7bb1f"
  
  curl -X GET "https://api.figshare.com/v2/account/projects/227034/articles/27867357" -H "Authorization: token f6ddeeb2f06f3a418c958d93b08e6ed501405d41ba90321069d49704fd61e9f846c06132e5756817c684db915f8b96b8cfcade2c57b81ba38e5c84537dc7bb1f"
  
  curl -X GET "https://api.figshare.com/v2/account/projects/227034/articles/27867357/files/" -H "Authorization: token f6ddeeb2f06f3a418c958d93b08e6ed501405d41ba90321069d49704fd61e9f846c06132e5756817c684db915f8b96b8cfcade2c57b81ba38e5c84537dc7bb1f"
  
  # 如果要新建一个article
  curl -X POST "https://api.figshare.com/v2/account/projects/227034/articles" \
       -d '{"title": "Your Article Title", "description": "Your article description"}' \
       -H "Authorization: token f6ddeeb2f06f3a418c958d93b08e6ed501405d41ba90321069d49704fd61e9f846c06132e5756817c684db915f8b96b8cfcade2c57b81ba38e5c84537dc7bb1f" \
       -H "Content-Type: application/json"
       
  curl -X GET "https://api.figshare.com/v2/account/articles" -H "Authorization: token f6ddeeb2f06f3a418c958d93b08e6ed501405d41ba90321069d49704fd61e9f846c06132e5756817c684db915f8b96b8cfcade2c57b81ba38e5c84537dc7bb1f"
  
  curl -X GET "https://api.figshare.com/v2/account/articles/27867357/files" -H "Authorization: token f6ddeeb2f06f3a418c958d93b08e6ed501405d41ba90321069d49704fd61e9f846c06132e5756817c684db915f8b96b8cfcade2c57b81ba38e5c84537dc7bb1f"
       
  ```

  - 注意：上传文件时，应为https://api.figshare.com/v2/account/articles/{article_id} 而不是 https://api.figshare.com/v2/account/projects/{project_id}/articles/{article_id}。

- [AGU data & software for authors](https://www.agu.org/publish-with-agu/publish/author-resources/data-and-software-for-authors)

  
