class OnboardingContents {
  final String title;
  final String image;
  final String desc;

  OnboardingContents({
    required this.title,
    required this.image,
    required this.desc,
  });
}

List<OnboardingContents> contents = [
  OnboardingContents(
    title: "Connect & Discover",
    image: "assets/images/image1.png",
    desc:
        "Easily find and offer a wide range of services. Simplify your search for jobs or candidates.",
  ),
  OnboardingContents(
    title: "Find Your Next Job",
    image: "assets/images/image2.png",
    desc:
        "Create your profile and connect with clients. Showcase your skills and discover new opportunities.",
  ),
  OnboardingContents(
    title: "Find the Right Talent",
    image: "assets/images/image3.png",
    desc:
        "Post your needs and browse profiles. Find the perfect professional for your requirements quickly",
  ),
];
