package com.user.sql;

import com.sun.org.apache.bcel.internal.generic.RET;

import javax.servlet.http.HttpServletRequest;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.util.Base64;

public class encryption {

    /**
     * 16进制字符
     */
    static String[] chars = {"0","1","2","3","4","5","6","7","8","9","a","b","c","d","e","f"};

    /**
     * 将普通字符串用md5加密，并转化为16进制字符串
     * @param str
     * @return
     */
    public static String StringInMd5(String str) {

        // 消息签名（摘要）
        MessageDigest md5 = null;
        try {
            // 参数代表的是算法名称
            md5 = MessageDigest.getInstance("md5");
            byte[] result = md5.digest(str.getBytes());

            StringBuilder sb = new StringBuilder(32);
            // 将结果转为16进制字符  0~9 A~F
            for (int i = 0; i < result.length; i++) {
                // 一个字节对应两个字符
                byte x = result[i];
                // 取得高位
                int h = 0x0f & (x >>> 4);
                // 取得低位
                int l = 0x0f & x;
                sb.append(chars[h]).append(chars[l]);
            }
            return sb.toString();

        } catch (NoSuchAlgorithmException e) {
            throw new RuntimeException(e);
        }
    }

    /**
     * 获取用户真实IP地址，不使用request.getRemoteAddr();的原因是有可能用户使用了代理软件方式避免真实IP地址,
     * 参考文章： http://developer.51cto.com/art/201111/305181.htm
     *
     * 可是，如果通过了多级反向代理的话，X-Forwarded-For的值并不止一个，而是一串IP值，究竟哪个才是真正的用户端的真实IP呢？
     * 答案是取X-Forwarded-For中第一个非unknown的有效IP字符串。
     *
     * 如：X-Forwarded-For：192.168.1.110, 192.168.1.120, 192.168.1.130,
     * 192.168.1.100
     *
     * 用户真实IP为： 192.168.1.110
     *
     * @param request
     * @return
     */
    public static String getIpAddress(HttpServletRequest request) {
        String ip = request.getHeader("x-forwarded-for");
        if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
            ip = request.getHeader("Proxy-Client-IP");
        }
        if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
            ip = request.getHeader("WL-Proxy-Client-IP");
        }
        if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
            ip = request.getHeader("HTTP_CLIENT_IP");
        }
        if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
            ip = request.getHeader("HTTP_X_FORWARDED_FOR");
        }
        if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
            ip = request.getRemoteAddr();
        }
        return ip;

    }



    //Base64 自定义加密函数处理
    private static int SaltValueNum = 0; //加密次数
    private static String GetSaltvalue="null";//盐值


    /**
     * @param src 要加密的字符串
     * @return 加密后的字符串
     */
    public static String GetBase64Encoder(String src){

        try {
            src+="{"+GetSaltvalue+"}";
            for (int x =0; x<SaltValueNum;x++){
                src= new String(Base64.getEncoder().encode(src.getBytes()));
            }
            return src;
        }catch (Exception e){
            throw new Error(e);
        }

    }

    /**
     * @param src 已加密的字符串
     * @return 解密后的字符串
     */
    public static String GetBase64Decoder(String src){

        try {
            for (int x =0; x<SaltValueNum;x++){
                src= new String(Base64.getDecoder().decode(src.getBytes()));
            }
            src = src.substring(0,src.length()-9);
            return src;
        }catch (Exception e){
            throw new Error(e);
        }

    }

}
