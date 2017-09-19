
const path = require('path')
const webpack = require('webpack');
const HtmlWebpackPlugin = require('html-webpack-plugin');
const ExtractTextPlugin = require("extract-text-webpack-plugin");
const CopyWebpackPlugin = require('copy-webpack-plugin');
const autoprefixer = require('autoprefixer');
const es3ifyPlugin = require('es3ify-webpack-plugin');
//const PathUrl='/'//本地路径
const PathUrl='${url.cdn}/'//本地路径
module.exports = {
    entry:{
        home_index:'./in/config/home_index.js',
        contact:'./in/config/contact.js',
        register_nav:'./in/config/register_nav.js',
        register:'./in/config/register.js',
        login:'./in/config/login.js',
        send_email:'./in/config/send_email.js',
        info:'./in/config/info.js',
        finish:'./in/config/finish.js',
        company_apply_refuse:'./in/config/company_apply_refuse.js',
        complete_material:'./in/config/complete_material.js',
        company_index:'./in/config/company_index.js',
        company_profile:'./in/config/company_profile.js',
        company_interview:'./in/config/company_interview.js',
        eliminate_template:'./in/config/eliminate_template.js',
        job_index:'./in/config/job_index.js',
        job_list:'./in/config/job_list.js',
        home_resume_main:'./in/config/home_resume_main.js',
        home_resume_educations:'./in/config/home_resume_educations.js',
        home_resume_experiences:'./in/config/home_resume_experiences.js',
        home_resume_index:'./in/config/home_resume_index.js',
        home_resume_preview:'./in/config/home_resume_preview.js',
        company_resume_view:'./in/config/company_resume_view.js',
        home_resume_download:'./in/config/home_resume_download.js',
        home_job_job_infomation:'./in/config/home_job_job_infomation.js',
        home_job_jobs:'./in/config/home_job_jobs.js',
        home_user_forget_index:'./in/config/home_user_forget_index.js',
        home_user_forget_reset:'./in/config/home_user_forget_reset.js',
        home_user_security_index:'./in/config/home_user_security_index.js',
        company_resume_manage:'./in/config/company_resume_manage.js',
        home_conversation_list:'./in/config/home_conversation_list.js',
        company_conversation_list:'./in/config/company_conversation_list.js',
        home_delivery_delivery:'./in/config/home_delivery_delivery.js',
        company_companies:'./in/config/company_companies.js',
        company_welcome:'./in/config/company_welcome.js',
        company_schedule:'./in/config/company_schedule.js',
        company_resume_query:'./in/config/company_resume_query.js',
        company_company_jobs:'./in/config/company_company_jobs.js',
        home_job_companies:'./in/config/home_job_companies.js',
        home_city_list:'./in/config/home_city_list.js',
        home_industry_list:'./in/config/home_industry_list.js',
    },
    output:{        
        path: path.resolve(__dirname, '../tradehelp-job-parent/tradehelp-job-webapp/src/main/webapp/'),
        filename: 'static/js/[name].js?v=[chunkhash:8]',
        publicPath:PathUrl
    },
    plugins: [
        new es3ifyPlugin(),
        new ExtractTextPlugin('static/css/[name].css?v=[contenthash:8]'),
        new HtmlWebpackPlugin({
            filename:'WEB-INF/public/public-salary.jsp',
            template:'html-withimg-loader!'+path.resolve('in/template/public/public-salary.jsp'),
            inject:'body',
            chunks:[""]
        }),
        new HtmlWebpackPlugin({
            filename:'WEB-INF/public/public-home-top-bar.jsp',
            template:'html-withimg-loader!'+path.resolve('in/template/public/public-home-top-bar.jsp'),
            inject:'body',
            chunks:[""]
        }),
        new HtmlWebpackPlugin({
            filename:'WEB-INF/public/public-icon.jsp',
            template:'html-withimg-loader!'+path.resolve('in/template/public/public-icon.jsp'),
            inject:'body',
            chunks:[""]
        }),
        new HtmlWebpackPlugin({
            filename:'WEB-INF/public/common_macro.jsp',
            template:'html-withimg-loader!'+path.resolve('in/template/public/common_macro.jsp'),
            inject:'body',
            chunks:[""]
        }),
        new HtmlWebpackPlugin({
            filename:'WEB-INF/public/public-js.jsp',
            template:'html-withimg-loader!'+path.resolve('in/template/public/public-js.jsp'),
            inject:'body',
            chunks:[""]
        }),
        new HtmlWebpackPlugin({
            filename:'WEB-INF/public/public-page.jsp',
            template:'html-withimg-loader!'+path.resolve('in/template/public/public-page.jsp'),
            inject:'body',
            chunks:[""]
        }),
        new HtmlWebpackPlugin({
            filename:'WEB-INF/public/public-unusual-state.jsp',
            template:'html-withimg-loader!'+path.resolve('in/template/public/public-unusual-state.jsp'),
            inject:'body',
            chunks:[""]
        }),
        new HtmlWebpackPlugin({
            filename:'WEB-INF/public/public-resume-delivery.jsp',
            template:'html-withimg-loader!'+path.resolve('in/template/public/public-resume-delivery.jsp'),
            inject:'body',
            chunks:[""]
        }),
        new HtmlWebpackPlugin({
            filename:'WEB-INF/public/public-home-head.jsp',
            template:'html-withimg-loader!'+path.resolve('in/template/public/public-home-head.jsp'),
            inject:'body',
            chunks:[""]
        }),
        new HtmlWebpackPlugin({
            filename:'WEB-INF/public/public-foot.jsp',
            template:'html-withimg-loader!'+path.resolve('in/template/public/public-foot.jsp'),
            inject:'body',
            chunks:[""]
        }),
        new HtmlWebpackPlugin({
            filename:'WEB-INF/public/public-company-head.jsp',
            template:'html-withimg-loader!'+path.resolve('in/template/public/public-company-head.jsp'),
            inject:'body',
            chunks:[""]
        }),
        new HtmlWebpackPlugin({
            filename:'WEB-INF/home/industry_list.jsp',
            template:'html-withimg-loader!'+path.resolve('in/template/home/industry_list.jsp'),
            inject:'body',
            chunks:["home_industry_list"]
        }),
        new HtmlWebpackPlugin({
            filename:'WEB-INF/home/city_list.jsp',
            template:'html-withimg-loader!'+path.resolve('in/template/home/city_list.jsp'),
            inject:'body',
            chunks:["home_city_list"]
        }),
        new HtmlWebpackPlugin({
            filename:'WEB-INF/company/schedule.jsp',
            template:'html-withimg-loader!'+path.resolve('in/template/company/schedule.jsp'),
            inject:'body',
            chunks:["company_schedule"]
        }),
        new HtmlWebpackPlugin({
            filename:'WEB-INF/company/resume_query.jsp',
            template:'html-withimg-loader!'+path.resolve('in/template/company/resume_query.jsp'),
            inject:'body',
            chunks:["company_resume_query"]
        }),
        new HtmlWebpackPlugin({
            filename:'WEB-INF/company/welcome.jsp',
            template:'html-withimg-loader!'+path.resolve('in/template/company/welcome.jsp'),
            inject:'body',
            chunks:["company_welcome"]
        }),
        new HtmlWebpackPlugin({
            filename:'WEB-INF/company/companies.jsp',
            template:'html-withimg-loader!'+path.resolve('in/template/company/companies.jsp'),
            inject:'body',
            chunks:["company_companies"]
        }),
        new HtmlWebpackPlugin({
            filename:'WEB-INF/home/job/companies.jsp',
            template:'html-withimg-loader!'+path.resolve('in/template/home/job/companies.jsp'),
            inject:'body',
            chunks:["home_job_companies"]
        }),
        new HtmlWebpackPlugin({
            filename:'WEB-INF/home/delivery/delivery.jsp',
            template:'html-withimg-loader!'+path.resolve('in/template/home/delivery/delivery.jsp'),
            inject:'body',
            chunks:["home_delivery_delivery"]
        }),
        new HtmlWebpackPlugin({
            filename:'WEB-INF/company/conversation/list.jsp',
            template:'html-withimg-loader!'+path.resolve('in/template/company/conversation/list.jsp'),
            inject:'body',
            chunks:["company_conversation_list"]
        }),
        new HtmlWebpackPlugin({
            filename:'WEB-INF/home/conversation/list.jsp',
            template:'html-withimg-loader!'+path.resolve('in/template/home/conversation/list.jsp'),
            inject:'body',
            chunks:["home_conversation_list"]
        }),
        new HtmlWebpackPlugin({
            filename:'WEB-INF/company/resume_manage.jsp',
            template:'html-withimg-loader!'+path.resolve('in/template/company/resume_manage.jsp'),
            inject:'body',
            chunks:["company_resume_manage"]
        }),
        new HtmlWebpackPlugin({
            filename:'WEB-INF/company/setting/profile.jsp',
            template:'html-withimg-loader!'+path.resolve('in/template/company/setting/profile.jsp'),
            inject:'body',
            chunks:["company_profile"]
        }),
        new HtmlWebpackPlugin({
            filename:'WEB-INF/company/jobManage/job_list.jsp',
            template:'html-withimg-loader!'+path.resolve('in/template/company/jobManage/job_list.jsp'),
            inject:'body',
            chunks:["job_list"]
        }),
        new HtmlWebpackPlugin({
            filename:'WEB-INF/company/jobManage/job_index.jsp',
            template:'html-withimg-loader!'+path.resolve('in/template/company/jobManage/job_index.jsp'),
            inject:'body',
            chunks:["job_index"]
        }),
        new HtmlWebpackPlugin({
            filename:'WEB-INF/company/delivery_employee.jsp',
            template:'html-withimg-loader!'+path.resolve('in/template/company/delivery_employee.jsp'),
            inject:'body',
            chunks:[""]
        }),
        new HtmlWebpackPlugin({
            filename:'WEB-INF/company/setting/interview_info.jsp',
            template:'html-withimg-loader!'+path.resolve('in/template/company/setting/interview_info.jsp'),
            inject:'body',
            chunks:["company_interview"]
        }),
        new HtmlWebpackPlugin({
            filename:'WEB-INF/company/setting/eliminate_template.jsp',
            template:'html-withimg-loader!'+path.resolve('in/template/company/setting/eliminate_template.jsp'),
            inject:'body',
            chunks:["eliminate_template"]
        }),
        new HtmlWebpackPlugin({
            filename:'WEB-INF/company/company_jobs.jsp',
            template:'html-withimg-loader!'+path.resolve('in/template/company/company_jobs.jsp'),
            inject:'body',
            chunks:["company_company_jobs"]
        }),
        new HtmlWebpackPlugin({
            filename:'WEB-INF/company/index.jsp',
            template:'html-withimg-loader!'+path.resolve('in/template/company/index.jsp'),
            inject:'body',
            chunks:["company_index"]
        }),
        new HtmlWebpackPlugin({
            filename:'WEB-INF/company/finally.jsp',
            template:'html-withimg-loader!'+path.resolve('in/template/company/finally.jsp'),
            inject:'body',
            chunks:["complete_material"]
        }),
        new HtmlWebpackPlugin({
            filename:'WEB-INF/company/apply/finish.jsp',
            template:'html-withimg-loader!'+path.resolve('in/template/company/apply/finish.jsp'),
            inject:'body',
            chunks:["finish"]
        }),
        new HtmlWebpackPlugin({
            filename:'WEB-INF/company/apply/info.jsp',
            template:'html-withimg-loader!'+path.resolve('in/template/company/apply/info.jsp'),
            inject:'body',
            chunks:["info"]
        }),   
        new HtmlWebpackPlugin({
            filename:'WEB-INF/company/apply/refuse.jsp',
            template:'html-withimg-loader!'+path.resolve('in/template/company/apply/refuse.jsp'),
            inject:'body',
            chunks:["company_apply_refuse"]
        }),
        new HtmlWebpackPlugin({
            filename:'WEB-INF/company/apply/send_email.jsp',
            template:'html-withimg-loader!'+path.resolve('in/template/company/apply/send_email.jsp'),
            inject:'body',
            chunks:["send_email"]
        }),
        new HtmlWebpackPlugin({
            filename:'WEB-INF/company/apply/email_invalid.jsp',
            template:'html-withimg-loader!'+path.resolve('in/template/company/apply/email_invalid.jsp'),
            inject:'body',
            chunks:["send_email"]
        }),
        new HtmlWebpackPlugin({
            filename:'WEB-INF/company/apply/contact.jsp',
            template:'html-withimg-loader!'+path.resolve('in/template/company/apply/contact.jsp'),
            inject:'body',
            chunks:["contact"]
        }),
        new HtmlWebpackPlugin({
            filename:'WEB-INF/home/index.jsp',
            template:'html-withimg-loader!'+path.resolve('in/template/home/index.jsp'),
            inject:'body',
            chunks:["home_index"]
        }),
        new HtmlWebpackPlugin({
            filename:'WEB-INF/home/register_nav.jsp',
            template:'html-withimg-loader!'+path.resolve('in/template/home/register_nav.jsp'),
            inject:'body',
            chunks:["register_nav"]
        }),
        new HtmlWebpackPlugin({
            filename:'WEB-INF/home/register.jsp',
            template:'html-withimg-loader!'+path.resolve('in/template/home/register.jsp'),
            inject:'body',
            chunks:["register"]
        }),
        new HtmlWebpackPlugin({
            filename:'WEB-INF/home/login.jsp',
            template:'html-withimg-loader!'+path.resolve('in/template/home/login.jsp'),
            inject:'body',
            chunks:["login"]
        }),
        new HtmlWebpackPlugin({
            filename:'WEB-INF/home/user/forget/index.jsp',
            template:'html-withimg-loader!'+path.resolve('in/template/home/user/forget/index.jsp'),
            inject:'body',
            chunks:["home_user_forget_index"]
        }),
        new HtmlWebpackPlugin({
            filename:'WEB-INF/home/user/forget/reset.jsp',
            template:'html-withimg-loader!'+path.resolve('in/template/home/user/forget/reset.jsp'),
            inject:'body',
            chunks:["home_user_forget_reset"]
        }),
        new HtmlWebpackPlugin({
            filename:'WEB-INF/home/user/security/index.jsp',
            template:'html-withimg-loader!'+path.resolve('in/template/home/user/security/index.jsp'),
            inject:'body',
            chunks:["home_user_security_index"]
        }),
        new HtmlWebpackPlugin({
            filename:'WEB-INF/home/resume/guide/main.jsp',
            template:'html-withimg-loader!'+path.resolve('in/template/home/resume/guide/main.jsp'),
            inject:'body',
            chunks:["home_resume_main"]
        }),
        new HtmlWebpackPlugin({
            filename:'WEB-INF/home/resume/guide/educations.jsp',
            template:'html-withimg-loader!'+path.resolve('in/template/home/resume/guide/educations.jsp'),
            inject:'body',
            chunks:["home_resume_educations"]
        }),
        new HtmlWebpackPlugin({
            filename:'WEB-INF/home/resume/guide/experiences.jsp',
            template:'html-withimg-loader!'+path.resolve('in/template/home/resume/guide/experiences.jsp'),
            inject:'body',
            chunks:["home_resume_experiences"]
        }),
        new HtmlWebpackPlugin({
            filename:'WEB-INF/home/resume/index.jsp',
            template:'html-withimg-loader!'+path.resolve('in/template/home/resume/index.jsp'),
            inject:'body',
            chunks:["home_resume_index"]
        }),
        new HtmlWebpackPlugin({
            filename:'WEB-INF/company/resume_view.jsp',
            template:'html-withimg-loader!'+path.resolve('in/template/company/resume_view.jsp'),
            inject:'body',
            chunks:["company_resume_view"]
        }),
        new HtmlWebpackPlugin({
            filename:'WEB-INF/home/resume/preview.jsp',
            template:'html-withimg-loader!'+path.resolve('in/template/home/resume/preview.jsp'),
            inject:'body',
            chunks:["home_resume_preview"]
        }),
        new HtmlWebpackPlugin({
            filename:'WEB-INF/home/resume/download.html',
            template:'html-withimg-loader!'+path.resolve('in/template/home/resume/download.html'),
            inject:'body',
            chunks:["home_resume_download"]
        }),
        new HtmlWebpackPlugin({
            filename:'WEB-INF/home/job/job_information.jsp',
            template:'html-withimg-loader!'+path.resolve('in/template/home/job/job_information.jsp'),
            inject:'body',
            chunks:["home_job_job_infomation"]
        }),
        new HtmlWebpackPlugin({
            filename:'WEB-INF/home/job/jobs.jsp',
            template:'html-withimg-loader!'+path.resolve('in/template/home/job/jobs.jsp'),
            inject:'body',
            chunks:["home_job_jobs"]
        }),
    ],
        module:{
        loaders:[
            {
                test:/\.js$/,
                loader:'babel-loader',
                exclude:path.resolve(__dirname, './node_modules/'),//打包范围
                options: {'presets': ['env']}
            },
            {
                exclude:path.resolve(__dirname, './node_modules/'),
                test:/\.txt$/,
                loader:'raw-loader'
            },
            {
                exclude:path.resolve(__dirname, './node_modules/'),
                test:/\.css$/,
                loader: ExtractTextPlugin.extract({
                    fallback: "style-loader",
                    use: [
                        {
                            loader: "css-loader",
                            options: {
                                sourceMap: true,
                                modules: true,
                                importLoaders: true,
                                localIdentName: "[local]"
                            }
                        },
                        {
                            loader: "postcss-loader",
                            options: {
                                plugins: function () {
                                    return [
                                        require("autoprefixer")
                                    ];
                                }
                            }
                        },
                    ],
                    publicPath:"../../"
                })
            },
            {
                exclude:path.resolve(__dirname, './node_modules/'),
                test:/\.(gif|jpg|png)$/i,
                loader:'url-loader?limit=20480&name=static/img/[name].[ext]?v=[hash:8]'
            },
            {
                exclude:path.resolve(__dirname, './node_modules/'),
                test:/\.(woff|svg|eot|ttf)$/i,
                loader:'url-loader?limit=8192&name=static/font/[name].[ext]?v=[hash:8]'
            }
        ]
    }
};