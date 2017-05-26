package com.youthlin.blog.web.front;

import com.google.common.collect.Lists;
import com.google.common.collect.Maps;
import com.google.common.collect.Multimap;
import com.google.common.collect.Sets;
import com.youthlin.blog.model.po.Post;
import com.youthlin.blog.model.po.Taxonomy;
import com.youthlin.blog.model.po.User;
import com.youthlin.blog.service.PostService;
import com.youthlin.blog.service.UserService;
import com.youthlin.blog.support.RssFeedViewer;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import java.util.List;
import java.util.Map;
import java.util.Set;

/**
 * 创建： youthlin.chen
 * 时间： 2017-05-26 18:42.
 */
@Controller
public class RssFeedController {
    @Resource
    private PostService postService;
    @Resource
    private UserService userService;

    @RequestMapping(path = {"/feed"})
    public ModelAndView feed() {
        ModelAndView mv = new ModelAndView("rssFeedViewer");
        List<Post> posts = postService.recentPublished(5);
        fetchAuthorInfo(posts, mv.getModel());
        fetchTaxonomyRelaships(posts, mv.getModel());
        mv.addObject(RssFeedViewer.POSTS, posts);
        return mv;
    }

    private void fetchAuthorInfo(List<Post> postList, Map<String, Object> model) {
        if (postList == null) {
            return;
        }
        Set<Long> userIds = Sets.newHashSet();
        for (Post post : postList) {
            userIds.add(post.getPostAuthorId());
        }
        List<User> users = userService.listById(userIds);
        Map<Long, User> userMap = Maps.newHashMap();
        for (User user : users) {
            userMap.put(user.getUserId(), user);
        }
        model.put(RssFeedViewer.USER_MAP, userMap);
    }

    private void fetchTaxonomyRelaships(List<Post> posts, Map<String, Object> model) {
        List<Long> ids = Lists.newArrayListWithExpectedSize(posts.size());
        for (Post post : posts) {
            ids.add(post.getPostId());
        }
        Long[] postIds = ids.toArray(new Long[0]);
        Multimap<Long, Taxonomy> postIdTaxonomyMultimap = postService.findTaxonomyByPostId(postIds);
        model.put(RssFeedViewer.TAXONOMY_Map, postIdTaxonomyMultimap.asMap());
    }
}

