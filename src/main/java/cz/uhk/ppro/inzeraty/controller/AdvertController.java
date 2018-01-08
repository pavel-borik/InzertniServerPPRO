package cz.uhk.ppro.inzeraty.controller;

import cz.uhk.ppro.inzeraty.model.Advert;
import cz.uhk.ppro.inzeraty.model.Category;
import cz.uhk.ppro.inzeraty.model.Comment;
import cz.uhk.ppro.inzeraty.model.User;
import cz.uhk.ppro.inzeraty.service.AdvertService;
import cz.uhk.ppro.inzeraty.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import java.io.IOException;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

@Controller
public class AdvertController {
    private final AdvertService advertService;
    private final UserService userService;

    @Autowired
    public AdvertController(AdvertService advertService, UserService userService) {
        this.advertService = advertService;
        this.userService = userService;
    }

    @RequestMapping(value ="/adverts/{advertId}", method = RequestMethod.GET)
    public ModelAndView showAdvert(@PathVariable("advertId") int advertId, @ModelAttribute("addedComment") Comment comment) {
        ModelAndView mav = new ModelAndView("advertDetail");

        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        Optional<User> loggedUser = userService.findByUsername(authentication.getName());
        if(loggedUser.isPresent()) mav.addObject("userId", loggedUser.get().getId());

        Optional<Advert> advert = advertService.findById(advertId);
        mav.addObject("comments", advert.get().getComments());
        if(advert.isPresent()) mav.addObject("advert", advert.get());

        return mav;
    }

    @RequestMapping(value ="/adverts/{advertId}", method = RequestMethod.POST)
    public String addRating(@PathVariable("advertId") int advertId, @ModelAttribute("addedComment") Comment comment) {
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        Optional<User> author = userService.findByUsername(authentication.getName());
        if(author.isPresent()) advertService.saveComment(comment, author.get(), advertId);
        return "redirect:/adverts/{advertId}";
    }

    @RequestMapping(value = "/adverts/new", method = RequestMethod.POST)
    public String create(@ModelAttribute("advert") Advert advert) throws IOException {
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        String currentPrincipalName = authentication.getName();
        User user = userService.findByUsername(currentPrincipalName).get();
        MultipartFile f = advert.getMpf();
        byte[] img = f.getBytes();
        advert.setImage(img);
        advertService.saveAdvert(advert, user);
        return "redirect:advertSuccess";
    }

    @RequestMapping(value = "/adverts/new", method = RequestMethod.GET)
    public ModelAndView showAdvertForm(@ModelAttribute("advert") Advert advert, ModelMap modelMap) {
        ModelAndView mav = new ModelAndView();
        mav.setViewName("advert");
        List<Category> categoryList;
        categoryList = advertService.findAllCategories();
        modelMap.put("categories", categoryList);
        return mav;
    }

    @RequestMapping(value = "/adverts/advertSuccess")
    public String showAdvertSuccess() {
        return "advertSuccess";
    }


}

