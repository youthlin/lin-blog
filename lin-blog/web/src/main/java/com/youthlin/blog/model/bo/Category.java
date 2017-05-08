package com.youthlin.blog.model.bo;

import com.google.common.collect.Lists;
import com.youthlin.blog.model.po.Taxonomy;

import java.util.List;

/**
 * 创建： youthlin.chen
 * 时间： 2017-05-08 22:32.
 */
public class Category extends Taxonomy {
    private int depth;
    private Category parentCategory = null;
    private List<Category> children = Lists.newArrayList();

    public Category() {
        setTaxonomy(Taxonomy.TAXONOMY_CATEGORY);
    }

    @Override
    public String toString() {
        return "Category{" +
                "depth=" + depth +
                ", parentCategory=" + parentCategory +
                ", children=" + children +
                "} " + super.toString();
    }

    @Override
    public Taxonomy setTaxonomy(String taxonomy) {
        return super.setTaxonomy(Taxonomy.TAXONOMY_CATEGORY);
    }

    public int getDepth() {
        return depth;
    }

    public Category setDepth(int depth) {
        this.depth = depth;
        return this;
    }

    public Category getParentCategory() {
        return parentCategory;
    }

    public Category setParentCategory(Category parentCategory) {
        this.parentCategory = parentCategory;
        return this;
    }

    public List<Category> getChildren() {
        return children;
    }

    public Category setChildren(List<Category> children) {
        this.children = children;
        return this;
    }
}